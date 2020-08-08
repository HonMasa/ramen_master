class AddColumnToPost < ActiveRecord::Migration[6.0]
  def change
    change_table :posts, bulk: true, latitude: Float
    add_column :posts, :longitude, :Float
  end
end
