class Post < ApplicationRecord
  belongs_to :profile

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many_attached :attachments, dependent: :destroy

  validates :description, length: { minimum: 10, message: 'Wpis musi posiadać conajmniej 10 znaków!' }

  def liked?(profile)
    self.likes.find { |like| like.profile_id == profile.id }
  end
end
