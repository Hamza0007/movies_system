class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :comment, presence: true, length: { maximum: 2000 }

  has_many :reported_reviews, dependent: :destroy

  def user_email
    self.user.email
  end

  def reported_by?(user)
    self.reported_reviews.where(user: user).present?
  end

end
