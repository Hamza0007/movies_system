class Movie < ActiveRecord::Base
  paginates_per 5

  include ThinkingSphinx::Scopes

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

  sphinx_scope(:latest) {
    {order: 'release_date DESC'}
  }

  sphinx_scope(:acknowledged) {
    { with: {approved: true} }
  }


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

  def self.default_search_conditions
    {
      conditions: {},
      with: { approved: true },
      order: 'release_date DESC',
    }
  end

  def self.search_movies(params)
    default_conditions = self.default_search_conditions
    default_conditions[:conditions][:genre] = params[:genre] if params[:genre].present?
    default_conditions[:conditions][:actors] = params[:actors] if params[:actors].present?
    default_conditions[:with][:release_date] = (Date.parse(params[:start_date])..Date.parse(params[:end_date])) if (params[:start_date] && params[:end_date]).present?

    self.search params[:search], default_conditions
  end

end
