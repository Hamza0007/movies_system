class AddValidationToFavouriteMovie < ActiveRecord::Migration
  def up
    change_column :favourite_movies, :user_id, :integer, null: false
    change_column :favourite_movies, :movie_id, :integer, null: false
  end

  def down
    change_column :favourite_movies, :user_id, :integer, null: true
    change_column :favourite_movies, :movie_id, :integer, null: true
  end
end
