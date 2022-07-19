require 'rails_helper'

RSpec.describe "New Party Page" do
  xit 'creates a new viewing party', :vcr do
    user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')
    user2 = User.create(name: 'Alex', email: 'Alex@testemail.com', password: 'password', password_confirmation: 'password')
    user3 = User.create(name: 'Geddy', email: 'Geddy@testemail.com', password: 'password', password_confirmation: 'password')
    party_count = Party.all.length

    visit "/"
    click_link "Login"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    visit "/"
    click_link "Login"

    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_button "Log In"

    visit "/"
    click_link "Login"

    fill_in "Email", with: user3.email
    fill_in "Password", with: user3.password
    click_button "Log In"

    visit "/movies/278"
    click_button "Create Viewing Party"

    fill_in "Duration", with: '200'
    fill_in "Start time", with: "2022-12-21 21:12:00"
    check("Alex")
    check("Drewb")
    click_button "Submit"

    expect(Party.all.length).to eq(party_count+1)
  end
end
