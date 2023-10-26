class Message < ApplicationRecord
  belongs_to :profile
  belongs_to :room

  after_create_commit { broadcast_append_to self.room }
end
