class Table < ActiveRecord::Base
  belongs_to :user
  belongs_to :tractate
  has_many :words

  def slug
    title_slug = self.title.gsub(" ","-").downcase
    if self.tractate
      tractate_slug = self.tractate.name.gsub(" ","-").downcase
      "#{tractate_slug}-#{title_slug}-#{self.user_id}"
    else
      "miscellaneous-#{title_slug}-#{self.user_id}"
    end
  end

  def self.find_by_slug(slug)
    all.find {|table| table.slug == slug}
  end

  def delete_words
    self.words.each do |word|
      word.delete
    end
  end

  def delete_word(word)
    self.words.delete(word)
  end

  def self.unique_slug?(slug, user)
    !user.tables.map {|table| table.slug }.include?(slug)
  end

  def self.public_tables
    all.select {|table| table.public == true}
  end
end
