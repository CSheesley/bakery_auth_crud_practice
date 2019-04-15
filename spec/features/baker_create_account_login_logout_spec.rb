require 'rails_helper'

RSpec.describe 'Bakers Account', type: :feature do
  context 'when I click on the create account link' do
    it 'displays a registration form, when filled out correctly, I am logged in and at my profile page, and I see a confirmation message' do

      visit root_path

      click_on "Create Account"

      fill_in "Name", with: "Corey"
      fill_in "Email", with: "corey@email.com"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      click_on "Submit"

      expect(page).to have_content("Welcome Corey!")
      expect(current_path).to eq(profile_path)
    end
  end

  context 'when I click on the login link' do
    it 'displays a form, when filled out correctly, I am logged in and at my profile page, and I see a confirmation message' do
      @baker = Baker.create(name: "Corey", email: "corey@email.com", password: "password", password_confirmation: "password")

      visit root_path

      click_on "Login"

      fill_in "Email", with: "corey@email.com"
      fill_in "Password", with: "password"
      click_on "Submit"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome Back Corey!")
    end
  end

  context 'when I click on the logout link' do
    it 'I see a confirmation message, and I am redirected back to the home page' do
      @baker = Baker.create(name: "Corey", email: "corey@email.com", password: "password", password_confirmation: "password")

      visit root_path

      click_on "Login"

      fill_in "Email", with: "corey@email.com"
      fill_in "Password", with: "password"
      click_on "Submit"

      visit root_path

      click_on "Logout"

      expect(page).to have_content("Successfully Logged out!")
      expect(current_path).to eq(root_path)
    end
  end
end
