class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :comment, presence: true

  has_many :reported_reviews, dependent: :destroy

  def user_email
    self.user.email
  end
end
