class AddValidationToRating < ActiveRecord::Migration
  def up
    change_column :ratings, :user_id, :integer, null: false
    change_column :ratings, :movie_id, :integer, null: false
  end

  def down
    change_column :ratings, :user_id, :integer, null: true
    change_column :ratings, :movie_id, :integer, null: true
  end
end
