class FavouriteMoviesController < ApplicationController

  def create
    unless FavouriteMovie.already_added_to_favourites?(current_user.id, params[:movie_id])
      @movie = Movie.find_by_id(params[:movie_id])
      @favourite = @movie.favourite_movies.new
      @favourite.user = current_user
      if @favourite.save
        @message = 'Successfully added movie to favorites'
      else
        @message = 'Could not add movie to favourites'
      end
    else
      @message = 'Movie Already added to favourites'
    end
  end

end
