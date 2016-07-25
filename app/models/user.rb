class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :reported_reviews, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy

  accepts_nested_attributes_for :attachment

  def profile_picture(style=:medium)
    attachment && attachment.try(:image).url(style) || "#{style.to_s}/missing.png"
  end

end
