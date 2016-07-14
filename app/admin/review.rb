ActiveAdmin.register Review do

  permit_params :user_id, :movie_id, :comment

  index do
    column :id
    column :comment
    column :report_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.all.map{ |user| [user.email, user.id] }
      f.input :movie
      f.input :comment
    end
    f.actions
  end

end
