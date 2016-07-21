module Api
  module V1
    class MoviesController < ApplicationController
      respond_to :json

    def index
      respond_with Movie.search_movie(params)
    end

    def show
      @movie = Movie.find_by_id(params[:id])
      respond_with @movie.movie_hash
    end

    end
  end
end
