class Word < ActiveRecord::Base
  belongs_to :table

  def self.parse(string)
    # array = []
    words = string.split(" ").uniq
    words.map! do |word|
        # hebrew = word.encode('utf-8')
        Word.create(hebrew: word)
    end
  end

end
