require 'rails_helper'

RSpec.describe "Registration Page" do
  it 'creates a new user' do
    user_count = User.all.length
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button "Register"
    expect(User.all.length).to eq(user_count+1)
  end

  it 'redirects to the user Dashboard' do
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button "Register"

    user = User.last
    expect(current_path).to eq("/users/#{user.id}")
  end

  it 'flashes an error with invalid credentials, missing fields' do
    visit '/users/register'
    # fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button "Register"

    expect(page).to have_content('Missing Credentials')
  end

  it 'flashes an error with invalid credentials, missing fields' do
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    # fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button "Register"

    expect(page).to have_content('Missing Credentials')
  end

  it 'flashes an error with invalid credentials, missing fields' do
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    # fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button "Register"

    expect(page).to have_content('Missing Credentials')
  end

  it 'flashes an error with invalid credentials, missing fields' do
    User.create(name: 'Drewb', email: 'Drew@testemail.com')
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    # fill_in :password_confirmation, with: 'password'
    click_button "Register"

    expect(page).to have_content('Missing Credentials')
  end

  it 'flashes an error with invalid credentials, repeat email' do
    User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button "Register"

    expect(page).to have_content('Invalid Entry')
  end

  it 'flashes an error with invalid credentials, password unconfirmed' do
    visit '/users/register'
    fill_in "Name", with: 'Drew'
    fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'pawwsord'
    click_button "Register"

    expect(page).to have_content('Missing Credentials')
  end
end
