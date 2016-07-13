module ReviewsHelper
  def check_review_owner(review)
    review.user == current_user
  end
end
