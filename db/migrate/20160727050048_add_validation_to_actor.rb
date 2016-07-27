class AddValidationToActor < ActiveRecord::Migration
  def up
    change_column :actors, :gender, :string, null: false, limit:6
  end

  def down
    change_column :actors, :gender, :string, null: true, limit:10
  end
end
