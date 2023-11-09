class Post < ApplicationRecord
  belongs_to :profile

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many_attached :attachments, dependent: :destroy

  def liked?(profile)
    self.likes.find { |like| like.profile_id == profile.id }
  end
end
