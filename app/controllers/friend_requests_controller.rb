class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:accept, :decline, :destroy]
  before_action :require_authorized_receiver, only: [:accept, :decline]
  before_action :require_authorized_sender, only: [:destroy]

  def create
    @friend_request = current_user.requests_sent.build(friend_request_params)
    if @friend_request.save
      flash[:success] = "Friend request sent"
    else
      flash[:danger] = "Some error occured"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friend_request.destroy
    flash[:succes] = "Successfuly deleted friend request"
    redirect_back(fallback_location: root_path)
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:receiver_id)
  end

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def require_authorized_receiver
    unless @friend_request.receiver == current_user
      flash[:danger] = "You're not authorized"
      redirect_back(fallback_location: root_path)
    end
  end

  def require_authorized_sender
    unless @friend_request.sender == current_user
      flash[:danger] = "You're not authorized"
      redirect_back(fallback_location: root_path)
    end
  end

end
