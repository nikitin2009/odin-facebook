class FriendshipsController < ApplicationController
  def create
    # debugger
    request = FriendRequest.find(params[:request_id])
    friendship = Friendship.new(active_friend: request.sender, passive_friend: request.receiver)
    if friendship.save
      flash[:success] = "You are now friends with #{request.sender.first_name}"
      request.destroy
    else
      flash[:danger] = "Something went wrong"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if user = User.find_by(id: params[:user_id])
      flash[:success] = "Succesfuly destroyed friendship"
      current_user.destroy_friendship(user)
    else
      flash[:danger] = "Something went wrong"
    end
    redirect_back(fallback_location: root_path)
  end

  private
    def friendship_params
      params.permit(:request_id)
    end
end
