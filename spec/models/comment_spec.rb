require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  describe "validations" do
    it "is invalid with content field length of more than 150 characters" do
      invalid_comment = FactoryBot.build(:comment, content: Faker::Lorem.paragraph_by_chars(151))
      expect(invalid_comment).to be_invalid
    end
  end

  describe "associations" do
    it "has belongs to User "do 
      assc = Comment.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "has belongs to Post "do 
      assc = Comment.reflect_on_association(:post)
      expect(assc.macro).to eq :belongs_to
    end
  end

end
