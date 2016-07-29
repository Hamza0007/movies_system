class AddValidationsToMovie < ActiveRecord::Migration
  def up
    change_column :movies, :title, :string, null: false, limit:50
  end

  def down
    change_column :movies, :title, :string, null: true, limit:30
  end
end
