require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "default scope" do
    it "retrieves post in desc order by created_at" do
      post1 = FactoryBot.create(:post)
      post2 = FactoryBot.create(:post)
      expect(Post.all.first).to eq(post2)
    end
  end
  
  describe "validations" do
    it "is invalid with empty content field" do
      invalid_post = FactoryBot.build(:post, content: nil)
      expect(invalid_post).to be_invalid
    end
  end

  describe "associations" do
    it "has belongs to User "do 
      assc = Post.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "has many Comments"do 
      assc = Post.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it "has many Likes"do 
      assc = Post.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end
  end

end
