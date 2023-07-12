class Bookmark < ApplicationRecord

  # user_id と board_idの組み合わせを一意性のあるものにしている
  validates :post_id, presence: true
  # validates :customer_id, presence: true
   #, uniqueness: { scope: :post_id }
   validates :customer_id, uniqueness: { scope: :post_id} 

   belongs_to :post#, optional: true
   belongs_to :customer#, optional: true

    def bookmarks(customer)
      bookmarks.where(customer_id: customer.id).exists?
    end

end