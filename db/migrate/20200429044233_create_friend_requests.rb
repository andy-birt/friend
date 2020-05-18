class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :receiver_id

      t.timestamps
    end
    add_index :friend_requests, :receiver_id
  end
end
