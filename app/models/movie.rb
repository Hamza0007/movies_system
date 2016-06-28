class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true
end
