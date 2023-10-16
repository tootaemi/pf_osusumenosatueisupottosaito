class Comment < ApplicationRecord
  validates :comment, presence: true
  belongs_to :post
  belongs_to :customer
end