class User < ApplicationRecord
    has_many :review
    before_create :init_review_count

    validates :username, uniqueness: true, presence: true
    validates :email, uniqueness: true, presence: true
    validate :user_birth_date

    def user_birth_date
        age = Time.now.year - self.brith_date.year
        if  age > 16
            p 'You should be 16 years old to create an account'
        end
    end

    private

    def init_review_count
        self.review_count =0
    end
end
