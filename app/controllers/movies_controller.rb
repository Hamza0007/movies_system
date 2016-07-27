class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :approved_movie, only: [:show]
  before_action :set_all_actors, only: [:new, :create, :edit]
  before_action :check_date, only: [:index]

  def index
    @movies = Movie.search_movies(params)
    @movies = @movies.page(params[:page])
  end

  def show
    @actors = @movie.actors
    @review = Review.new
    @ratings = @movie.ratings
    @rating = @movie.get_movie_ratings(current_user) if user_signed_in?

    respond_to do |format|
      format.html
      format.json { render json: @movie }
    end
  end

  def new
    @movie = Movie.new
  end

  def edit
    @selected = @movie.actors.pluck(:id)
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_movie
    @movie = Movie.find_by_id(params[:id])
    redirect_to root_path, notice: 'Movie does not exists' unless @movie.present?
  end

  def set_all_actors
    @all_actors = Actor.all.pluck(:name, :id)
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :trailer, :featured, :genre, :release_date, :duration, :approved, actor_ids: [],
     attachments_attributes: [:id, :image, :_destroy])
  end

  def approved_movie
    redirect_to root_path, notice: 'Movie is not approved' unless @movie.approved
  end

  def check_date
    return if params[:start_date].blank? && params[:end_date].blank?
    if params[:start_date].present? && params[:end_date].blank?
      message = 'Please enter end date'
    elsif params[:start_date].blank? && params[:end_date].present?
      message = 'Please enter start date'
    elsif params[:start_date] > params[:end_date]
      message = 'Please enter valid start date and end date'
    end
      redirect_to movies_path, notice: message if message
  end

end
