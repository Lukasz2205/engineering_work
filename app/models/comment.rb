class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :post, optional: true
  belongs_to :parent, class_name: 'Comment', foreign_key: :parent_id, optional: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :root_comments, -> { where(parent_id: nil) }

  def all_descendants
    descendants = []
    self.replies.each do |reply|
      descendants << reply
      descendants.concat(reply.all_descendants)
    end
    descendants
  end

  def root_comment
    current_comment = self
    current_comment = current_comment.parent while current_comment.parent
    current_comment
  end

  def liked?(profile)
    self.likes.find { |like| like.profile_id == profile.id }
  end
end
