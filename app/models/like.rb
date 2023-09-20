class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :post

  validates :profile_id, uniqueness: {scope: :post_id}
end
