class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.uuid :assigned_by, null: false, foreign_key: true, type: :uuid
      t.references :object, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
