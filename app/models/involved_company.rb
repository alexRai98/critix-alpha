class InvolvedCompany < ApplicationRecord
  belongs_to :company
  belongs_to :game

  validates :developer, presence: true 
  validates :publisher, presence: true

end
