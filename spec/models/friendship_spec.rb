require 'rails_helper'

RSpec.describe Friendship, type: :model do

  describe "associations" do
    it "belongs to active_friend "do 
      assc = Friendship.reflect_on_association(:active_friend)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to passive_friend "do 
      assc = Friendship.reflect_on_association(:passive_friend)
      expect(assc.macro).to eq :belongs_to
    end
  end

end
