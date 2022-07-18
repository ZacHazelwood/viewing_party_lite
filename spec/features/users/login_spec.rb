require 'rails_helper'

RSpec.describe "User Login Page" do
  it "allows a login" do
    user = User.create(name: 'Drewb', email: 'Drew@testemail.com', password: 'password', password_confirmation: 'password')

    visit '/login'

    fill_in "Email", with: 'Drew@testemail.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button "Log In"

    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_content('Welcome Drew')
  end
end
