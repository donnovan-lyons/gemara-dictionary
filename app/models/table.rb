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
end
