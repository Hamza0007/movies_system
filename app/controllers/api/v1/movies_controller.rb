module Api
  module V1
    class MoviesController < ApplicationController
      before_action :authenticate_request
      before_action :set_movie, only: [:show]
      respond_to :json

      DEFAULT_SEARCH_FILTER = { approved: true }
      DEFAULT_SEARCH_ORDER = 'release_date DESC'

      def index
        respond_with search_movie(params).page(params[:page])
      end

      def show
        respond_with movie_hash(@movie)
      end


      private

      def set_movie
        @movie = Movie.find_by_id(params[:id])
        render json: { error: 'Record not found', status: 404 } if @movie.blank?
      end

      def authenticate_request
        unless request.headers['Authorization'] == ENV['TOKEN']
          head :unauthorized
        end
      end

      def movie_hash(movie)
        movie_attachments = []
        movie.attachments.each do |attachment|
          movie_attachments << attachment.image.url
        end
        {
          movie_details: movie,
          actors: movie.actors.pluck(:id, :name, :biography, :gender),
          reviews: movie.reviews.pluck(:id, :user_id, :comment, :report_count),
          posters: movie.attachments.pluck(:id, :image_file_name, :image_content_type, :image_file_size),
          path: movie_attachments,
        }
      end

      def search_movie(params)
        if params[:title] || params[:genre] || params[:actors] || params[:release_date]

          conditions = {}
          conditions[:title] = params[:title] if params[:title].present?
          conditions[:genre] = params[:genre] if params[:genre].present?
          conditions[:actors] = params[:actors] if params[:actors].present?
          conditions[:release_date] = params[:release_date] if params[:release_date].present?

          Movie.search(conditions: conditions, with: DEFAULT_SEARCH_FILTER, order: DEFAULT_SEARCH_ORDER)
        else
          Movie.all
        end
      end

    end
  end
end
