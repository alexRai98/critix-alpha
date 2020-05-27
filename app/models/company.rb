class Company < ApplicationRecord
    has_many :involved_company
    has_many :reviews, :as => :reviewable

    validates :name, presence: true, uniqueness: true
    validates :country, presence: true
    
end
