class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_movie
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :require_permission, only: :edit

  def edit
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user_id = current_user.id
    @review.save
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

  def require_permission
    unless current_user == @review.user
      redirect_to root_path
    end
  end
end
