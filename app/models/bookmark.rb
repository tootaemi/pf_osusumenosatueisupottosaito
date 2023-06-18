class Bookmark < ApplicationRecord
  
  # user_id と board_idの組み合わせを一意性のあるものにしている
   validates :customer_id, uniqueness: { scope: :post_id }
    validate :post_id

      belongs_to :post#, optional: true
      belongs_to :customer, optional: true
end


