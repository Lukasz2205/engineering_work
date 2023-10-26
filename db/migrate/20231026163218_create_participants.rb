class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants, id: :uuid do |t|
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.references :room, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
