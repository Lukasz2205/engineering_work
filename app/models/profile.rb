class Profile < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :followed_profiles, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_profiles
  has_many :following_profiles, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_profiles
  has_many :notifications, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :rooms

  has_one_attached :avatar, dependent: :destroy

  before_validation :set_default_name, if: -> { name.nil? }

  validates_uniqueness_of :name
  validates :description, length: { maximum: 150 }
  after_create_commit { broadcast_append_to "profiles" }

  scope :all_except, ->(profile) { where.not(id: profile) }

  def blocked?
    block == true
  end

  private

  def set_default_name
    self.name = "User##{current_user.id[0..5]}"
  end
end
