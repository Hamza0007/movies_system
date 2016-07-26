class FavouriteMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie
  before_action :favourite_movie_already_added? , only: [:create]

  def create
    favourite = @movie.favourite_movies.new
    favourite.user = current_user
    if favourite.save
      message = 'Successfully added movie to favorites.'
    else
      message = 'Could not add movie to favourites.'
    end
    redirect_to @movie, notice: message
  end

  private

  def set_movie
    @movie = Movie.find_by_id(params[:movie_id])
  end

  def favourite_movie_already_added?
    return unless FavouriteMovie.already_added_to_favourites?(current_user, params[:movie_id])
    redirect_to @movie, notice: 'Movie already added to favourites.'
  end

end
