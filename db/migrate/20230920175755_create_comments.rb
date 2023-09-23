class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :message
      t.integer :parent_id, type: :uuid
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.references :post, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
