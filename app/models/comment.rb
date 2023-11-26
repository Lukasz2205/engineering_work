class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :post, optional: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, as: :object, dependent: :destroy

  def liked?(profile)
    self.likes.find { |like| like.profile_id == profile.id }
  end
end
