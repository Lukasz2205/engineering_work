class Profile < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
end
