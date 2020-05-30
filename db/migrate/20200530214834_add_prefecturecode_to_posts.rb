class AddPrefecturecodeToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :prefecture_code, :integer
  end
end
