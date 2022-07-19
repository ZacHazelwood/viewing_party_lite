require 'rails_helper'

RSpec.describe "Dashboard Page" do
  xit 'has correct title' do
    user = User.create(name: 'Geddy', email: '2112@yyz.com', password: 'password', password_confirmation: 'password')
    visit "/dashboard"

    expect(page).to have_content("Geddy's Dashboard")
  end

  it 'has a button to navigate to discover movie page', :vcr do
    user = User.create(name: 'Geddy', email: '2112@yyz.com', password: 'password', password_confirmation: 'password')

    visit "/"
    click_link "Login"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    visit "/dashboard"
    click_button("Discover Movies")

    expect(current_path).to eq("/users/#{user.id}/discover")
  end

  xit 'shows all viewing parties the user is invited or hosting with details', :vcr do
    user1 = User.create(name: 'Geddy', email: '2112@yyz.com', password: 'password', password_confirmation: 'password')
    user2 = User.create(name: 'Alex', email: 'cygnus@xanadu.com', password: 'password', password_confirmation: 'password')
    user3 = User.create(name: 'Neil', email: 'bytor@snowdog.com', password: 'password', password_confirmation: 'password')
    party1 = Party.create(start_time: '2022-05-10', duration: 147, host: user2.id, movie_id: 123, host_name: "Alex")
    party2 = Party.create(start_time: '2022-05-14', duration: 147, host: user1.id, movie_id: 124, host_name: "Neil")
    PartyUser.create(user_id: user1.id, party_id: party1.id )
    PartyUser.create(user_id: user2.id, party_id: party1.id )
    PartyUser.create(user_id: user3.id, party_id: party1.id )
    PartyUser.create(user_id: user1.id, party_id: party2.id )
    PartyUser.create(user_id: user2.id, party_id: party2.id )

    visit "/dashboard"

    within "#invited" do
      expect(page).to have_content("Geddy")
      expect(page).to have_content("Alex")
      expect(page).to have_content("No End")
      expect(page).to have_content("2022-05-14")

      # expect(page).to_not have_content("The Lord of the Rings")
    end

    within "#hosting" do
      expect(page).to have_content("Geddy")
      expect(page).to have_content("Neil")
      expect(page).to have_content("The Lord of the Rings")
      expect(page).to have_content('2022-05-10')

      expect(page).to_not have_content("No End")
    end
  end

  xit 'links to movie show page', :vcr do
    user1 = User.create(name: 'Geddy', email: '2112@yyz.com', password: 'password', password_confirmation: 'password')
    user2 = User.create(name: 'Alex', email: 'cygnus@xanadu.com', password: 'password', password_confirmation: 'password')
    user3 = User.create(name: 'Neil', email: 'bytor@snowdog.com', password: 'password', password_confirmation: 'password')
    party1 = Party.create(start_time: '2022-05-10', duration: 147, host: user2.id, movie_id: 123, host_name: "Alex")
    party2 = Party.create(start_time: '2022-05-14', duration: 147, host: user1.id, movie_id: 124, host_name: "Geddy")
    PartyUser.create(user_id: user1.id, party_id: party1.id )
    PartyUser.create(user_id: user2.id, party_id: party1.id )
    PartyUser.create(user_id: user3.id, party_id: party1.id )
    PartyUser.create(user_id: user1.id, party_id: party2.id )
    PartyUser.create(user_id: user2.id, party_id: party2.id )

    visit "/dashboard"
    click_link("The Lord of the Rings")

    expect(current_path).to eq("/users/#{user2.id}/movies/123")
  end
end
