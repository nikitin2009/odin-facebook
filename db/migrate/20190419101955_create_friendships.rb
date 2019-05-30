class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :active_friend, references: :users
      t.references :passive_friend, references: :users

      t.timestamps
    end

    add_index :friendships, [:active_friend_id, :passive_friend_id], unique: true
  end
end
