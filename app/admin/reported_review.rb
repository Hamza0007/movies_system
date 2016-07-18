ActiveAdmin.register ReportedReview do

  permit_params :user_id, :review_id

  index do
    column :id
    column :user_id
    column :review_id
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.all.map{ |user| [user.email, user.id] }
      f.input :review_id, as: :select, collection: Review.all.map{ |review| [review.id] }
    end
    f.actions
  end
end
