class AddPostIdToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :post_id, :integer
  end
end
