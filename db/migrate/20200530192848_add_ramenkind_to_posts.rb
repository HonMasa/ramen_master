class AddRamenkindToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :ramen_kind, :string
  end
end
