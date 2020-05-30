class AddShopnameToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :shop_name, :string
  end
end
