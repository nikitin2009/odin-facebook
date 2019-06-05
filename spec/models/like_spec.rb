require 'rails_helper'

RSpec.describe Like, type: :model do

  describe "associations" do
    it "belongs to User "do 
      assc = Like.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to Post "do 
      assc = Like.reflect_on_association(:post)
      expect(assc.macro).to eq :belongs_to
    end
  end

end
