class Bookmark < ApplicationRecord
  
  # user_id と board_idの組み合わせを一意性のあるものにしている
   validates :customer_id, presence: true
   #, uniqueness: { scope: :post_id }
   validates :post_id, presence: true
   
   belongs_to :post#, optional: true
   belongs_to :customer, optional: true
end

