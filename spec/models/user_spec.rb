require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do

    let(:valid_user) { FactoryBot.build(:user) }
    let(:invalid_user) { FactoryBot.build(:user, first_name: nil) }

    context "complete user details" do
      it "is valid" do
        expect(valid_user).to be_valid
      end
    end

    context "incomplete user details" do
      it "is not valid" do
        expect(invalid_user).to be_invalid
      end
    end

  end
end
