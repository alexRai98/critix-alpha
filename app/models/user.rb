class User < ApplicationRecord
    has_many :review
    after_create :init_review_count

    private

    def init_review_count
        self.review_count =0
    end
end
