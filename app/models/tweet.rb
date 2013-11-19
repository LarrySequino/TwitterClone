class Tweet < ActiveRecord::Base
    belongs_to :user
    has_many :stars

    has_and_belongs_to_many :hashtags

    validates :body, presence: true
end
