class AddValidationToMovie < ActiveRecord::Migration
  def up
    change_column :movies, :title, :string, null: false, limit:30
    change_column :movies, :trailer, :string, null: false
    change_column :movies, :release_date, :date, null: false
  end

  def down
    change_column :movies, :title, :string, null: true, limit:150
    change_column :movies, :trailer, :string, null: true
    change_column :movies, :release_date, :date, null: true
  end
end
