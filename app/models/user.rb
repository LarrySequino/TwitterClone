class User < ActiveRecord::Base
	has_many :relationships
    has_many :followers, :through => :relationships, :source => :follower_id
    has_many :followed_users, :through => :relationships, :source => :followed_id
    has_many :tweets
    has_many :starred_tweets, through: :stars

    has_secure_password
end
