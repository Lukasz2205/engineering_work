class Profile < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  before_validation :set_default_name, if: -> { name.nil? }

  private

  def set_default_name
    self.name = "User##{current_user.id[0..5]}"
  end
end
