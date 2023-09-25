class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :message
      t.references :parent, null: true, type: :uuid
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.references :post, null: true, foreign_key: true, optional: true, type: :uuid

      t.timestamps
    end
  end
end
