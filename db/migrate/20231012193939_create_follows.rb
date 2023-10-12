class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :followings, id: :uuid do |t|
      t.uuid :follower_id
      t.uuid :followed_id

      t.timestamps
    end
  end
end
