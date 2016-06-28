class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, limit: 150
      t.text :description
      t.string :trailer
      t.boolean :featured, default: false
      t.boolean :approved, default: false

      t.timestamps null: false
    end
  end
end
