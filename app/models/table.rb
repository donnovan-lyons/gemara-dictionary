class Table < ActiveRecord::Base
  belongs_to :user
  belongs_to :tractate
  has_many :words

  def slug
    self.title.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    all.find {|table| table.slug == slug}
  end
end
