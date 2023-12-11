class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'Profile'
  belongs_to :followee, class_name: 'Profile'

  validates :follower_id, uniqueness: { scope: :followee_id }
  validates :followee_id, uniqueness: { scope: :follower_id }
end
