class User < ActiveRecord::Base
  validates_presence_of :username, :password, :password_confirmation
  validates_uniqueness_of :username
  validates_confirmation_of :password
  attr_accessor :password_confirmation
  has_secure_password
  has_many :tables
  has_many :words, through: :tables
  has_many :user_tractates
  has_many :tractates, through: :user_tractates
end
