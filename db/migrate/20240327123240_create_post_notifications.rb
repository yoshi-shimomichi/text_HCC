class CreatePostNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :post_notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id, null:false
      t.integer :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    add_index :post_notifications, :visitor_id
    add_index :post_notifications, :visited_id
    add_index :post_notifications, :post_id
  end
end
