class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true
  validates :genre, presence: true

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :casts, dependent: :destroy
  has_many :actors, through: :casts

  accepts_nested_attributes_for :attachments, allow_destroy: true

  GENRE = ['Action', 'Thriller', 'Romance', 'Horror']
end
