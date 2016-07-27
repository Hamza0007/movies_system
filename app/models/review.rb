class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates :comment, presence: true, length: { maximum: 2000 }

  has_many :reported_reviews, dependent: :destroy

  def user_email
    self.user.email
  end

  def reported_by?(user)
    reported_reviews.where(user: user).present?
  end

  def self.create_reported_review(user, review)
    report = review.reported_reviews.new
    report.user_id = user.id
    report.save
    review.report_count += 1
    review.save
  end

end
