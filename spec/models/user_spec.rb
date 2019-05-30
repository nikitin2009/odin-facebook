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
    let(:john) { FactoryBot.create(:user) }
    let(:mike) { FactoryBot.create(:user) }
    let(:charles) { FactoryBot.create(:user) }
    let(:rachel) { FactoryBot.create(:user) }

    before do
      FactoryBot.create(:friendship, active_friend: john, passive_friend: mike)
      FactoryBot.create(:friendship, active_friend: charles, passive_friend: john)
      FactoryBot.create(:friendship, active_friend: rachel, passive_friend: john)
    end

    describe "#friends" do
      it "returns a user's complete set of friends" do
        expect(john.friends.count).to be(3)
      end
    end
  end

end
