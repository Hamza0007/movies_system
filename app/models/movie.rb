class Movie < ActiveRecord::Base

  include ThinkingSphinx::Scopes

  SEARCH_PER_PAGE = 12
  PER_PAGE = 6

  paginates_per PER_PAGE

  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :trailer, presence: true
  validates :genre, presence: true
  validates :release_date, presence: true
  validates :description, length: { maximum: 350 }

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :casts, dependent: :destroy
  has_many :actors, through: :casts
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true

  GENRE = ['action', 'thriller', 'romance', 'horror']

  sphinx_scope(:latest) {
    {order: 'release_date DESC'}
  }

  sphinx_scope(:acknowledged) {
    { with: {approved: true} }
  }

  scope :feature, -> { where(featured: true).sort }
  scope :top, -> { joins('LEFT OUTER JOIN ratings ON movies.id = ratings.movie_id').group('movies.id').order('AVG(ratings.score) DESC') }
  scope :sort, -> { order('release_date DESC') }
  scope :approved, -> { where(approved: true).sort }
  scope :without_sort, -> { order('release_date ASC') }
  scope :without_top, -> { joins(:ratings).group('movie_id').order('AVG(ratings.score) ASC') }

  def get_average_rating
    ratings.present? ? ratings.average(:score) : 0
  end

  def get_movie_ratings(user)
    user.ratings.for_movie(self).first || ratings.new
  end

  def first_poster(style=:medium)
    attachments.first && attachments.first.try(:image).url(style) || "#{style.to_s}/missing.png"
 end

  def self.get_movies(filter)
    movie = self.includes(:attachments)
    return movie.sort.approved if filter == 'Latest'
    return movie.top.approved if filter == 'Top'
    return movie.feature.approved if filter == 'Featured'
    return movie.sort.approved
  end

  def self.get_movies_sort_type(param)
    if param == 'rating_descending'
      top.approved
    elsif param == 'rating_ascending'
      without_top.approved
    elsif param == 'release_date_ascending'
      without_sort.approved
    elsif param == 'release_date_descending'
      approved
    else
      all.approved
    end
  end

  def self.default_search_conditions(page)
    {
      conditions: {},
      with: { approved: true },
      order: 'release_date DESC',
      page: page,
      per_page: SEARCH_PER_PAGE,
    }
  end

  def self.search_movies(params)
    if(params[:filter]).present?
      get_movies(params[:filter])
    elsif (params[:sort]).present?
      get_movies_sort_type(params[:sort])
    else
      default_conditions = self.default_search_conditions(params[:page])
      default_conditions[:conditions][:genre] = params[:genre] if params[:genre].present?
      default_conditions[:conditions][:actors] = params[:actors] if params[:actors].present?
      default_conditions[:with][:release_date] = (Date.parse(params[:start_date])..Date.parse(params[:end_date])) if (params[:start_date].present? && params[:end_date]).present?
      self.search params[:search], default_conditions
    end
  end

  def self.date_range(start_date, end_date)
    if start_date.present? && end_date.present?
      Date.parse(start_date)..Date.parse(end_date)
    elsif start_date.present?
      Date.parse(start_date)..Date.today
    end
  end

end
