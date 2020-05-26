class Game < ApplicationRecord
    has_and_belongs_to_many :genre
    has_and_belongs_to_many :platform

    has_many :games
    belongs_to :parent,  :class_name => "Game"

    has_many :reviews, :as => :reviewable
end
