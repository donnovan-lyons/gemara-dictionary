class Tractate < ActiveRecord::Base
  has_many :tables
  has_many :user_tractates
  has_many :users, through: :user_tractates
end
