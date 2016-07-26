class ReportedReviewsController < ApplicationController

  def create
    unless ReportedReview.already_reported?(current_user.id, params[:review_id])
      @review = Review.find_by_id(params[:review_id])
      Review.create_reported_review(current_user, @review)
    end
  end
end
