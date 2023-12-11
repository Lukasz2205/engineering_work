class Profile < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :followings, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_profiles, through: :followings, source: :followed
  has_many :followers, through: :reverse_followings, source: :follower
  has_many :reverse_followings, foreign_key: :followed_id, class_name: 'Following', dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :assigned_by, through: :notifications
  has_many :rooms

  has_one_attached :avatar, dependent: :destroy

  before_validation :set_default_name, if: -> { name.nil? }

  validates_uniqueness_of :name
  after_create_commit { broadcast_append_to "profiles" }

  scope :all_except, ->(profile) { where.not(id: profile) }

  private

  def set_default_name
    self.name = "User##{current_user.id[0..5]}"
  end
end
