require 'rails_helper'

RSpec.describe "Landing Page" do
  it 'displays title of application' do
    visit '/'
    expect(page).to have_content("Viewing Party")
  end

  it 'has button that links to create new user' do
    visit '/'

    click_button("Create New User")
  end

  it 'links to landing page' do
    visit '/'
    drew = User.create(name: "Drew Proebstel", email: "drew@turdmail.com", password: 'password', password_confirmation: 'password')
    click_link("Landing Page")
    expect(current_path).to eq("/")
  end

  it 'links to login page' do
    visit '/'

    expect(page).to have_link("Login")
    click_link "Login"

    expect(current_path).to eq("/login")
  end

  it 'links to logout' do
    visit '/'

    expect(page).to have_link("Login")
    click_link "Login"

    user = User.create!(name: 'Drewb', email: 'Drewtestemail.com', password: 'password', password_confirmation: 'password')

    visit "/"
    click_link "Login"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    expect(current_path).to eq("/dashboard")

    visit "/"
    expect(page).to have_content("You are logged in")
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Log Out")

    expect(current_path).to eq("/")

    visit "/"
    click_link("Log Out")
    expect(page).to have_link("Login")
  end

  it "only shows other user emails if a user is logged in" do
    user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')
    user2 = User.create(name: 'Alex', email: 'Alex@testemail.com', password: 'password', password_confirmation: 'password')
    user3 = User.create(name: 'Geddy', email: 'Geddy@testemail.com', password: 'password', password_confirmation: 'password')

    visit "/"
    expect(page).to_not have_content('Drew@testemail.com')
    expect(page).to_not have_content('Alex@testemail.com')
    expect(page).to_not have_content('Geddy@testemail.com')

    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"
    click_link "Login"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    visit "/"

    expect(page).to have_content('Alex@testemail.com')
    expect(page).to have_content('Geddy@testemail.com')
  end
end
