require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do

    let(:valid_user) { FactoryBot.build(:user) }
    let(:invalid_first_name) { FactoryBot.build(:user, first_name: nil) }
    let(:invalid_last_name) { FactoryBot.build(:user, last_name: nil) }

    context "complete user details" do
      it "is valid" do
        expect(valid_user).to be_valid
      end
    end

    context "incomplete user details" do
      it "is invalid without a first name" do
        expect(invalid_first_name).to be_invalid
      end
      it "is invalid without a last name" do
        expect(invalid_last_name).to be_invalid
      end
    end

    it "does not allow duplicate emails" do
      User.create!(
        first_name: "Test",
        last_name: "test",
        email: "test@mail.com",
        password: "123456"
      )
      new_user = User.new(email: "test@mail.com")
      new_user.valid?
      expect(new_user.errors[:email]).to include("has already been taken")
    end
  end

  describe "instance methods" do
    let(:user) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:user3) { FactoryBot.create(:user) }
    let(:user4) { FactoryBot.create(:user) }

    let(:post) { FactoryBot.create(:post) }
    let(:post2) { FactoryBot.create(:post) }
    let(:post3) { FactoryBot.create(:post) }

    before do
      FactoryBot.create(:friendship, active_friend: user, passive_friend: user2)
      FactoryBot.create(:friendship, active_friend: user3, passive_friend: user)
      FactoryBot.create(:friendship, active_friend: user4, passive_friend: user)
    end

    describe "#friends" do
      it "returns a user's complete set of friends" do
        expect(user.friends.count).to be(3)
      end
    end

    describe "#liked_post" do
      it "returns true if user has liked a given post" do
        post.likes.create(user: user)
        expect(user.liked_post?(post)).to be(true)
      end
    end

    describe "#feed" do
      it "returns all posts from all friends of a user" do
        user.posts << post
        user2.posts << post2
        user3.posts << post3
        user4.active_friends += [user, user2, user3]
        expect(user4.feed.count).to eq(3)
      end
    end
  end

end
