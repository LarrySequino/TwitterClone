class Hashtag < ActiveRecord::Base
    has_and_belongs_to_many :tweets

    validates :name, uniqueness: true
    validates :name, presence: true
end
