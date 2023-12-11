class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows, id: :uuid do |t|
      t.uuid :follower_id, type: :uuid
      t.uuid :followee_id, type: :uuid

      t.timestamps
    end
  end
end
