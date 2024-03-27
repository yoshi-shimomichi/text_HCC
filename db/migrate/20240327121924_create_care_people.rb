class CreateCarePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :care_people do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :age
      t.integer :sex, default: 0
      t.integer :care_level, default: 0
      t.text :bio

      t.timestamps
    end
  end
end
