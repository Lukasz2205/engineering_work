class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.references :recipient, foreign_key: { to_table: :profiles }, type: :uuid
      t.references :notifiable, optional: true, polymorphic: true, index: true, type: :uuid
      t.string :text
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
