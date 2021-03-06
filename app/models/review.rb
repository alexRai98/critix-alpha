class Review < ApplicationRecord
    belongs_to :user
    belongs_to :reviewable, :polymorphic => true

    after_create :add_review
    after_destroy :subtract_review

    validates :title, presence: true, length: { maximum: 40 }, uniqueness: true
    validates :body, presence: true

    private
    def add_review
        user = User.find(self.user_id)
        user.update(review_count: user.review_count+1) 
    end
    def subtract_review
        user = User.find(self.user_id)
        user.update(review_count: user.review_count-1) 
    end
end
