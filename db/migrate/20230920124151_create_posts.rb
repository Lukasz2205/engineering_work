class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :description
      t.references :profile, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
