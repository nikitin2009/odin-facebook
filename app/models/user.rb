class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :requests_sent, foreign_key: :sender_id,
            class_name: "FriendRequest", dependent: :destroy

  has_many :requests_received, foreign_key: :receiver_id,
            class_name: "FriendRequest", dependent: :destroy

  has_many :active_friendships, class_name: "Friendship", foreign_key: :active_friend_id, dependent: :destroy
  has_many :passive_friendships, class_name: "Friendship", foreign_key: :passive_friend_id,
            dependent: :destroy

  has_many :active_friends, through: :passive_friendships
  has_many :passive_friends, through: :active_friendships

  def friends
    active_friends + passive_friends
  end

  def liked_post?(post)
    self.likes.include?(Like.find_by(post_id: post.id))
  end

  # TO-DO Fix - Refactor
  #PostsControllerTest#test_should_get_index:
  #ActionView::Template::Error: PG::SyntaxError: ERROR:  syntax error at or near ")"
  #LINE 1: SELECT "posts".* FROM "posts" WHERE (user_id IN ()
  def feed
    friends_ids = self.friends.map(&:id).join(',')
    unless friends_ids.blank?
      Post.where("user_id IN (#{friends_ids})
                OR user_id = :user_id", user_id: id)
    else
      Post.where("user_id = :user_id", user_id: id)
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split[1]
      user.image = auth.info.image 
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
