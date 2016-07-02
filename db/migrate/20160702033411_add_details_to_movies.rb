class AddDetailsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :genre, :string, null: false
    add_column :movies, :release_date, :date
    add_column :movies, :duration, :integer
  end
end
