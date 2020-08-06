class AddColumnToPost < ActiveRecord::Migration[6.0]
  def change
    change_table :posts, bulk: true, latitude: float
    add_column :posts, :longitude, :float
  end
end
