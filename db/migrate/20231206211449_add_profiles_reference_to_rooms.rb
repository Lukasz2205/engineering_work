class AddProfilesReferenceToRooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :rooms, :profile, type: :uuid
  end
end
