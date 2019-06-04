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

  describe "validations" do
    it "ensures uniqueness of pair [sender, receiver] / [receiver, sender]" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      request_from_1_to_2 = FriendRequest.create(sender: user1, receiver: user2)
      request_from_2_to_1 = FriendRequest.new(sender: user2, receiver: user1)
      expect(request_from_2_to_1.valid?).to be false
    end
  end

end
