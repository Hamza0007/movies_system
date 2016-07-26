class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true

  scope :for_movie, -> (movie) { where(movie: movie) }
end
