class Game < ApplicationRecord
    has_and_belongs_to_many :genre
    has_and_belongs_to_many :platform
end
