class Actor < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :gender, presence: true, length: { maximum: 6 }, inclusion: { in: ['Male', 'Female'] }

  has_many :casts, dependent: :destroy
  has_many :movies, through: :casts
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true

  def first_poster(style=:medium)
    attachments.first && attachments.first.try(:image).url(style) || "#{style.to_s}/missing.png"
  end
end
