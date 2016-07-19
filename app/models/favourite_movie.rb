class FavouriteMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  def self.already_added_to_favourites?(user, movie)
    self.exists?(user_id: user, movie_id: movie)
  end
end
