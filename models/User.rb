class User < ActiveRecord::Base
  has_many :posts
  has_many :user_friends
  has_many :friends, through: :user_friends
end
