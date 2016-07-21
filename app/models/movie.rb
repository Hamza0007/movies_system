class Movie < ActiveRecord::Base
  paginates_per 5

  include ThinkingSphinx::Scopes

  DEFAULT_SEARCH_FILTER = { approved: true }
  DEFAULT_SEARCH_ORDER = 'release_date DESC'

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

  scope :feature, -> { where(featured: true).sort }
  scope :top, -> { joins(:ratings).group('movie_id').order('AVG(ratings.score) DESC') }
  scope :sort, -> { order('release_date DESC') }
  scope :approved, -> { where(approved: true).sort }

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
    return self.sort.approved if filter == "Latest"
    return self.top.approved if filter == "Top"
    return self.feature.approved if filter == "Featured"
  end

  def self.default_search_conditions
    {
      conditions: {},
      with: { approved: true },
      order: 'release_date DESC',
    }
  end

  def self.search_movies(params)
    if(params[:filter])
      get_movies(params[:filter])
    else
      default_conditions = self.default_search_conditions
      default_conditions[:conditions][:genre] = params[:genre] if params[:genre].present?
      default_conditions[:conditions][:actors] = params[:actors] if params[:actors].present?
      default_conditions[:with][:release_date] = date_range(params[:start_date], params[:end_date]) if params[:start_date].present?
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

  def movie_hash
    {
      movie_details: self,
      actors: self.actors.pluck(:id, :name, :biography, :gender),
      reviews: self.reviews.pluck(:id, :user_id, :comment, :report_count)
    }
  end

  def self.search_movie(params)
    if params[:title] || params[:genre] || params[:actors] || params[:release_date]
      conditions = {
        title: params[:title],
        genre: params[:genre],
        actors: params[:actors],
        release_date: params[:release_date]
      }

      Movie.search(conditions: conditions, with: DEFAULT_SEARCH_FILTER, order: DEFAULT_SEARCH_ORDER)
    else
      Movie.all
    end
  end

end
