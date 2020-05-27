class Game < ApplicationRecord
    has_and_belongs_to_many :genre
    has_and_belongs_to_many :platform

    has_many :games
    belongs_to :parent,  :class_name => "Game"

    has_many :reviews, :as => :reviewable   

    enum category: {main_game: 0, expansion: 1}

    validates :name, presence: true, uniqueness: true
    validates :category, presence: true
    validates :rating, numericality:{ greater_than_or_equal_to: 0 , less_than_or_equal_to: 100 }
    validate :validate_parent_id_expansion_category


    def validate_parent_id_expansion_category
        if expansion? 
            if parent.nil?
                errors.add(:parent, "parent_id is required")
            end
        end
    end

        
end
