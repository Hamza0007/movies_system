ActiveAdmin.register Movie do

  permit_params :title, :description, :trailer, :featured, :approved, :genre, :release_date, attachments_attributes: [:id, :image, :_destroy], actor_ids: []

  index do
    column :title
    column :actors do |movie|
      movie.movie_cast
    end
    column 'Description' do |movie|
      movie.description.html_safe
    end
    column :genre
    column :featured
    column :approved
    column "Poster" do |movie|
      image_tag(movie.first_poster.image.url(:thumb)) if movie.first_poster
    end
    column :release_date
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :trailer
      f.input :featured
      f.input :approved
      f.input :duration
      f.input :actors
      f.input :genre, as: :select, collection: Movie::GENRE
      f.input :release_date
      f.has_many :attachments, heading: 'Posters', new_record: 'Add Poster' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:medium)), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
      end
    end
   f.actions
  end

end
