class Hashtag < ApplicationRecord

    # validates :hashname, presence: true, length: { maximum: 50 }
    # has_many :post_tags, dependent: :destroy
    # has_many :posts, through: :hashtag_posts
end

