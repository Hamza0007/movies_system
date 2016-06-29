class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :trailer, presence: true

  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
