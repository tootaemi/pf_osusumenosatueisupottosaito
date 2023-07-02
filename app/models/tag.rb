class Tag < ApplicationRecord
  validates :tag_name, presence: true, length: { maximum: 120 }
  
  has_many :post_tags
  has_many :posts, through: :post_tags
  
  

  
end
