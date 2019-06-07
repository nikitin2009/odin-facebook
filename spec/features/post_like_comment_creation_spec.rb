require 'rails_helper'

RSpec.feature "Post Like Comment Creation", type: :feature do

  before do
    @post = FactoryBot.build(:post)
    @comment = FactoryBot.build(:comment)
    @current_user = FactoryBot.create(:user)
    sign_in_with @current_user
  end

  scenario "User creates a new post" do
    visit root_path
    fill_in "Create new post:", with: @post.content
    click_button "Create Post"

    expect(page).to have_text(@post.content)
  end

  scenario "User likes a post" do
    FactoryBot.create(:post, user: @current_user)
    visit root_path
    click_button "Like"

    expect(page).to have_button("Liked")
  end

  scenario "User leaves a comment for a post" do
    FactoryBot.create(:post, user: @current_user)
    visit root_path
    fill_in "Add your comment:", with: @comment.content
    click_button "Add comment"

    expect(page).to have_text(@comment.content)
  end

  def sign_in_with(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
