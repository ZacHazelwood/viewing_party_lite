require 'rails_helper'

RSpec.describe "User Login Page" do
  describe "Happy Path" do
    it "allows a login" do
      user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')

      visit '/login'

      fill_in "Email", with: 'Drew@testemail.com'
      fill_in :password, with: 'password'
      click_button "Log In"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content('Welcome Drew')
    end
  end

  describe "Sad Path" do
    it "redirects to log in page from failed login, missing email" do
      user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')

      visit '/login'

      # fill_in "Email", with: 'Drew@testemail.com'
      fill_in :password, with: 'password'
      click_button "Log In"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Invalid Entry")
    end

    it "redirects to log in page from failed login, missing password" do
      user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')

      visit '/login'

      fill_in "Email", with: 'Drew@testemail.com'
      # fill_in :password, with: 'password'
      click_button "Log In"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Invalid Entry")
    end

    it "redirects to log in page from failed login, email misspelled" do
      user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')

      visit '/login'

      fill_in "Email", with: 'D@testemail.com'
      fill_in :password, with: 'password'
      click_button "Log In"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Invalid Entry")
    end
  end
end
