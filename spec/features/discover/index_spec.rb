require 'rails_helper'

RSpec.describe 'Discover Index Page' do
  describe "button link paths" do
    before :each do
      @user = User.create!(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')

      visit "/"
      click_link "Login"

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log In"
    end

    it "has a button to discover top rated movies", :vcr do
      visit "/discover"

      expect(page).to have_button("Discover Top Rated Movies")

      click_button("Discover Top Rated Movies")

      expect(current_path).to eq("/movies")
    end

    it "has a search field to find movies by title", :vcr do
      visit "/discover"

      fill_in "search", with: "Shaw"
      click_button("Search")

      expect(current_path).to eq("/movies")
    end
  end
end
