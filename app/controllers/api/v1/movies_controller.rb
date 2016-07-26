module Api
  module V1
    class MoviesController < ApplicationController
      before_action :authenticate_request
      respond_to :json

      TOKEN = 'E06CB98E1930F2F8'

      def index
        respond_with Movie.search_movie(params)
      end

      def show
        @movie = Movie.find_by_id(params[:id])
        respond_with @movie.movie_hash
      end

      def authenticate_request
        unless request.headers['Authorization'] == TOKEN
          head :unauthorized
        end
      end

    end
  end
end
