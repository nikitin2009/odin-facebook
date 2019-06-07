require 'rails_helper'

RSpec.feature "Visitor signs up", type: :feature do

  scenario 'with valid information' do
    user = FactoryBot.build(:user)
    sign_up_with user
    expect(page).to have_content('Sign out')
  end

  scenario 'with invalid email' do
    user_invalid_email = FactoryBot.build(:user, email: 'invalid.com')
    sign_up_with user_invalid_email

    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    user_blank_password = FactoryBot.build(:user, password: '')
    sign_up_with user_blank_password

    expect(page).to have_content('Sign in')
  end

  def sign_up_with(user)
    visit new_user_registration_path
    fill_in 'First name', with: user.first_name
    fill_in 'Last name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
  end

end
