class Tag < ApplicationRecord
  validates :tag_name, presence: true, length: { maximum: 120 }
  has_many :post_tags
  has_many :posts, through: :post_tags
  
  def self.search(search)
    if search != '#'
      tag = Tag.where(name: search)
      tag[0].cars
    else
      Post.all
    end
  end
  
end