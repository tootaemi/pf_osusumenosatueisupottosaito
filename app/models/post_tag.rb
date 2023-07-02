class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  
  # belongs_to :hashtag
  # validates :post_id, presence: true
  # validates :hashtag_id, presence: true
end

