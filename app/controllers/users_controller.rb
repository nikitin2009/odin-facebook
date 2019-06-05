class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:me, :edit, :friends]

  def index
    requests_received_from = current_user.requests_received.map { |r| r.sender }
    @users = User.all - current_user.friends - requests_received_from - [current_user]
  end

  def me

  end


  def show
  end

  def friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end
end
