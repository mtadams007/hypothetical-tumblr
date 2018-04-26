class UserFriend < ActiveRecord::Base
  belongs_to :users
  belongs_to :friends
end
