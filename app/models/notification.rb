class Notification < ApplicationRecord
  belongs_to :profile
  belongs_to :recipient, class_name: 'Profile'
  belongs_to :notifiable, optional: true, polymorphic: true

  validates :profile_id, uniqueness: { scope: %i[recipient_id notifiable_id text] }, unless: -> { (notifiable_type == 'Profile' || notifiable_type == 'Post' || notifiable_type == 'Comment' ) }
  validate :different_profile_and_recipient

  scope :recipient, ->(recipient) { where(recipient: recipient) }
  scope :unread, -> { where(read: false ).order(created_at: :desc) }
  scope :read, ->{ where(read: true ).order(created_at: :desc) }

  private

  def different_profile_and_recipient
    if profile_id && recipient_id && profile_id == recipient_id
      errors.add(:base, "Nie można dodać notyfikacji dla samego siebie")
    end
  end
end