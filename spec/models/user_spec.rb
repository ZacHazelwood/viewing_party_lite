require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_uniqueness_of(:email)}
    # it { should validate_uniqueness_of(:password_digest)}
  end

  describe 'associations' do
    it { should have_many(:parties).through(:party_users)}
    it { should have_many(:party_users)}
  end
end
