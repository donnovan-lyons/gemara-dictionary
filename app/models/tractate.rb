class Tractate < ActiveRecord::Base
  has_many :tables
  has_many :users, through: :tables

  def slug
    self.name.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    all.find {|tractate| tractate.slug == slug}
  end

  def display_users
    user_count = users.uniq.count
    if user_count == 0
      "No users are studying this tractate."
    elsif user_count == 1
      "#{users[0].username} is studying this tractate."
    else
      "The users #{users.uniq.map {|user| user.username}.join(", ")} are studying this tractate."
    end
  end

end
