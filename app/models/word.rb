class Word < ActiveRecord::Base
  belongs_to :table

  def self.parse(string, current_user)
    # array = []
    words = string.split(" ").uniq
    words.map! do |word|
      if current_user.words.none? {|w| w.hebrew == word}
        Word.create(hebrew: word)
      end
    end
  end

end
