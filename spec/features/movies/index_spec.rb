require 'rails_helper'

RSpec.describe 'Movies Index/Results Page' do
  before :each do
    @user = User.create!(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')

    visit "/"
    click_link "Login"

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log In"
  end

  it "displays the top rated movies", :vcr do
    visit "/discover"
    click_button("Discover Top Rated Movies")
    expect(page).to have_link("The Shawshank Redemption")
    expect(page).to have_content("Vote Average: 8.7")
    expect(page).to have_link("Gabriel's Inferno")
    expect(page).to have_content("Vote Average: 8.5")
  end

  it "displays movies related to a prior search", :vcr do
    visit "/discover"
    fill_in "search", with: "Shaw"
    click_button("Search")

    expect(page).to have_link("Fast & Furious Presents: Hobbs & Shaw")
    expect(page).to have_link("Roy Shaw: Brute Force")
    expect(page).to_not have_link("Gabriel's Inferno")
  end

  it "links to a movie's details, show page", :vcr do
    visit "/discover"
    click_button("Discover Top Rated Movies")

    click_link("The Shawshank Redemption")
    expect(current_path).to eq("/movies/278")
  end
end
