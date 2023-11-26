class Notification < ApplicationRecord
  belongs_to :profile
  belongs_to :assigned_by, class_name: 'profile', optional: true
  belongs_to :object, polymorphic: true
end
