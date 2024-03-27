class CreatePostFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :post_favorites do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :post_favorites, [:user_id, :post_id], unique: true
  end
end
