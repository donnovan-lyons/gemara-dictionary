class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
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

  def words_translated
    self.words.count {|word| word.translation_present?}
  end

end
