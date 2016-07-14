class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_all_actors, only: [:new, :create, :edit]

  # GET /movies
  # GET /movies.json
  def index
    @movies = params[:filter] == "Latest" ? Movie.latest : Movie.feature
    @movies = @movies.page(params[:page])
  end

  # GET /movies/1
  # GET /movies/1.json
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

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    @selected = @movie.actors.pluck(:id)
  end

  # POST /movies
  # POST /movies.json
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

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
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

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def set_all_actors
      @all_actors = Actor.all.pluck(:name, :id)
    end

    def movie_params
      params.require(:movie).permit(:title, :description, :trailer, :featured, :genre, :release_date, :duration, :approved, actor_ids: [],
       attachments_attributes: [:id, :image, :_destroy])
    end
end
