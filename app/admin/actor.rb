ActiveAdmin.register Actor do

  permit_params :name , :biography, :gender, attachments_attributes: [:id, :image, :_destroy]

  index do
    column :id
    column :name
    column :biography
    column :gender
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :biography
      f.input :gender
      f.has_many :attachments, heading: 'Posters', new_record: 'Add Poster' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:medium)), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
      end
    end
  f.actions
  end

end
