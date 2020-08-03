class AddNameProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true
    add_column :users, :profile, :text
  end
end
