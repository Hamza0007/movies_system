class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_movie

  def edit
  end

  def create
    @review = @movie.reviews.create(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to movie_path(@movie), notice: 'Review was successfully created.' }
      else
        format.html { render :new }
      end
      format.js
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to movie_path(@movie), notice: 'Review was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to movie_path(@movie), notice: 'Review was successfully destroyed.' }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:user_id, :movie_id, :comment)
  end
end
