class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:me, :edit, :friends]

  def index
    @users = User.all - current_user.friends - [current_user]
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
