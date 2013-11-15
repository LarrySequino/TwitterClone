class User < ActiveRecord::Base
    has_many :relationships, class_name: 'Relationship', foreign_key: :followed_user_id
    has_many :followers, through: :relationships

    has_many :reverse_relationships, class_name: 'Relationship', foreign_key: :follower_id
    has_many :followed_users, through: :reverse_relationships

    has_many :tweets
    has_many :stars
    has_many :starred_tweets, through: :stars, source: :tweet
    has_secure_password
end

