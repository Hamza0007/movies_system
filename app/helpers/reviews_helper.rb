module ReviewsHelper
  def check_user(review)
    review.user_id == current_user.id
  end
end
