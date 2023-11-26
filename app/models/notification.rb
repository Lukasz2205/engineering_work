class Notification < ApplicationRecord
  belongs_to :profile
  belongs_to :recipient, class_name: 'Profile'
  belongs_to :notifiable, polymorphic: true
end
