class User < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username
  has_secure_password
  has_many :tables
  has_many :words, through: :tables
  has_many :tractates, through: :tables

  def delete_all_words_and_tables
    self.tables.each do |table|
      table.delete_words
      table.delete
    end
  end
end
