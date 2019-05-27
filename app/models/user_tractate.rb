class UserTractate < ActiveRecord::Base
  belongs_to :user
  belongs_to :tractate

end
