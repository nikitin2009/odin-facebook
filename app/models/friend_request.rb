class FriendRequest < ApplicationRecord
  validate :cannot_send_request_when_received_from_same_user

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  private
    def cannot_send_request_when_received_from_same_user
      received = FriendRequest.find_by(receiver: sender)
      if received && received.sender == receiver
        errors.add(:duplicate, "there is a request between the two users")
      end
    end
end
