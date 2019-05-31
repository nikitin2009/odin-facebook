require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe "validations" do
    it "is invalid with empty content field" do
      invalid_post = FactoryBot.build(:post, content: nil)
      expect(invalid_post).to be_invalid
    end
  end

end
