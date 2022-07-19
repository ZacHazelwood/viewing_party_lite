require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_uniqueness_of(:email)}
    it { should have_secure_password }

    it "expects password stuff" do
      user = User.create!(name: 'Meg', email: 'meg2@test.com', password: 'password', password_confirmation: 'password')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq("password")
    end
  end

  describe 'associations' do
    it { should have_many(:parties).through(:party_users)}
    it { should have_many(:party_users)}
  end
end
