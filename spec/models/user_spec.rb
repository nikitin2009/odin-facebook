require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do

    let(:valid_user) { FactoryBot.build(:user) }
    let(:invalid_user) { FactoryBot.build(:user, name: nil) }

    context "complete user details" do
      it "is valid" do
        expect(valid_user).to be_valid
      end
    end

  end
end
