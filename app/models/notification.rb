class Notification < ApplicationRecord
  belongs_to :profile
  belongs_to :recipient, class_name: 'Profile'
  belongs_to :notifiable, polymorphic: true

  validates :profile_id, uniqueness: { scope: %i[recipient_id notifiable_id] }
end