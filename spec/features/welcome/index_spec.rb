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


  it 'displays name of user' do

    drew = User.create!(name: "Drew Proebstel", email: "drew@turdmail.com", password: 'password', password_confirmation: 'password')
    alex = User.create!(name: "Zac Hazelwood", email: "zach@turdmail.com", password: 'password', password_confirmation: 'password')

    visit '/'

    expect(page).to have_content("Drew Proebstel")
    expect(page).to have_content("Zac Hazelwood")

  end

  it 'links to users dashboard' do
    drew = User.create(name: "Drew Proebstel", email: "drew@turdmail.com", password: 'password', password_confirmation: 'password')
    visit '/'
    click_link("Drew Proebstel")
    expect(current_path).to eq("/users/#{drew.id}")
  end

  it 'links to landing page' do
    visit '/'
    drew = User.create(name: "Drew Proebstel", email: "drew@turdmail.com", password: 'password', password_confirmation: 'password')
    click_link("Landing Page")
    expect(current_path).to eq("/")
  end


end
