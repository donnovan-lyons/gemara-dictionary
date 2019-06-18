class Word < ActiveRecord::Base
  belongs_to :table

  def self.parse(string, user)
    words = string.split(" ").uniq
    hebrew_words = user.words.map {|word| word.hebrew}
    words.reject! {|w| hebrew_words.include?(w) }
    words.map! {|word| Word.create(hebrew: word)}
    words
  end

  def translation_present?
    array = [self.translation_one, self.translation_two, self.translation_three]
    array.any? {|word| word != "" && word != nil }
  end

end
