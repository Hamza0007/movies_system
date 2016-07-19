class Movie < ActiveRecord::Base
  paginates_per 5

  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true
  validates :genre, presence: true
  validates :release_date, presence: true

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :casts, dependent: :destroy
  has_many :actors, through: :casts
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true

  GENRE = ['Action', 'Thriller', 'Romance', 'Horror']

  scope :feature, -> { where(featured: true) }
  scope :top, -> { joins(:ratings).group('movie_id').order('AVG(ratings.score) DESC') }
  scope :sort, -> { order('release_date DESC') }
  scope :approved, -> { where(approved: true) }

  def get_average_rating
    self.ratings.present? ? self.ratings.average(:score) : 0
  end

  def get_movie_ratings(user)
    user.ratings.for_movie(self).first || self.ratings.new
  end

  def movie_cast
    self.actors.pluck(:name).join(', ')
  end

  def first_poster(style=:medium)
    attachments.first && attachments.first.try(:image).url(style) || "#{style.to_s}/missing.png"
 end

  def self.get_movies(filter)
    return self.sort if filter == "Latest"
    return self.top if filter == "Top"
    return self.feature if filter == "Featured"
  end

end
