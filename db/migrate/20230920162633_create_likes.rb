class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :object_type

      t.timestamps
    end
  end
end
