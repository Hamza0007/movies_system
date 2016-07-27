class AddValidationToReview < ActiveRecord::Migration
  def up
    change_column :reviews, :comment, :text, null: false
  end

  def down
    change_column :reviews, :comment, :text, null: true
  end
end
