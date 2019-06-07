require 'rails_helper'

RSpec.feature "Visitor Signs In", type: :feature do

  scenario 'with valid information' do
    user = FactoryBot.create(:user)
    sign_in_with user
    expect(page).to have_content('Sign out')
  end

  scenario 'with invalid information' do
    user_blank_password = FactoryBot.create(:user)
    user_blank_password.password = ''
    sign_in_with user_blank_password

    expect(page).to have_content('Sign in')
  end

  def sign_in_with(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
