class Movie < ActiveRecord::Base
  paginates_per 5

  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true
  validates :genre, presence: true

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :casts, dependent: :destroy
  has_many :actors, through: :casts
  has_many :reviews

  accepts_nested_attributes_for :attachments, allow_destroy: true

  GENRE = ['Action', 'Thriller', 'Romance', 'Horror']

  scope :feature, -> { where(featured: true) }
  scope :latest, -> { order('release_date DESC') }

end
