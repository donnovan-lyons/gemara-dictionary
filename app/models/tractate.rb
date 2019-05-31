class Tractate < ActiveRecord::Base
  has_many :tables
  has_many :users, through: :tables

  def slug
    self.name.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    all.find {|tractate| tractate.slug == slug}
  end
end
