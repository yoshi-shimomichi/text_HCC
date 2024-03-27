class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :post_type,  null: false
      t.text :body, null: false
      t.string :post_image

      t.timestamps
    end
  end
end
