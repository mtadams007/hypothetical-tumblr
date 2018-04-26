class Friend < ActiveRecord::Base
  has_many :posts
  has_many :user_friends
  has_many :users, through: :user_friends
end
