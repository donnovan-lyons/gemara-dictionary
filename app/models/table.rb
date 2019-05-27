class Table < ActiveRecord::Base
  belongs_to :user
  belongs_to :tractate
  has_many :words
end
