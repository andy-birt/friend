class MultipleTables < ActiveRecord::Migration[6.0]
  def change
    rename_column :likes, :post_id, :likable_id
    rename_column :comments, :post_id, :commentable_id
    add_column :likes, :likable_type, :string
    add_column :comments, :commentable_type, :string
  end
end
