class CreateCommentNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :comment_id, null:false
      t.integer :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    add_index :comment_notifications, :visitor_id
    add_index :comment_notifications, :visited_id
    add_index :comment_notifications, :comment_id
  end
end
