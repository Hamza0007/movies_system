class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  has_many :reported_reviews, dependent: :destroy

  def user_email
    self.user.email
  end
end
