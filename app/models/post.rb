class Post < ApplicationRecord
  belongs_to :profile

  has_many :likes, dependent: :destroy

  def liked?(profile)
    self.likes.find { |like| like.profile_id == profile.id }
  end
end
