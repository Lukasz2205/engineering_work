class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :post

  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
end
