require 'rails_helper'

RSpec.feature "User Adds A Friend", type: :feature do
  
  before do
    @current_user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    sign_in_with @current_user
  end

  scenario "User sends a friend request to another user" do
    visit users_path
    click_button "Add Friend"

    expect(page).to have_text("Friend request sent")
  end

  scenario "User receives a friend request from another user" do
    visit users_path
    click_button "Add Friend"
    click_link "Sign out"
    sign_in_with @another_user

    expect(page).to have_text("My friends(1)")
  end

  scenario "User accepts a friend request from another user" do
    visit users_path
    click_button "Add Friend"
    click_link "Sign out"
    sign_in_with @another_user
    visit me_friends_path
    click_button "Accept"

    expect(page).to have_text("You are now friends with #{@current_user.first_name}")
  end

  scenario "User declines a friend request from another user" do
    visit users_path
    click_button "Add Friend"
    click_link "Sign out"
    sign_in_with @another_user
    visit me_friends_path
    click_link "Decline"

    expect(page).to have_text("Friend request removed")
  end

  def sign_in_with(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
