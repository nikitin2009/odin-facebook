require 'rails_helper'

RSpec.describe FriendRequest, type: :model do

  describe "associations" do
    it "belongs to sender "do 
      assc = FriendRequest.reflect_on_association(:sender)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to receiver "do 
      assc = FriendRequest.reflect_on_association(:receiver)
      expect(assc.macro).to eq :belongs_to
    end
  end

end
