class Message < ApplicationRecord
  belongs_to :profile
  belongs_to :room

  before_create :confirm_participant

  validates :content, length: { minimum: 1 }

  def confirm_participant
    if self.room.is_private
      is_participant = Participant.where(profile_id: self.profile.id, room_id: self.room.id).first
      throw :abort unless is_participant
    end
  end

  after_create_commit { broadcast_append_to self.room }
end
