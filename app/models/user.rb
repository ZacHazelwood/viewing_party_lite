class User < ApplicationRecord
  has_many :party_users
  has_many :parties, :through => :party_users
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_presence_of :password_digest

  has_secure_password

  has_many :party_users
  has_many :parties, through: :party_users
end
