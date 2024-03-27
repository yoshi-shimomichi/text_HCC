class CreateCommentFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_favorites do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
    add_index :comment_favorites, [:user_id, :comment_id], unique: true
  end
end
