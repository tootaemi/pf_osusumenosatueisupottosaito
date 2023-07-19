class Bookmark < ApplicationRecord

  # user_id と board_idの組み合わせを一意性のあるものにしている
  validates :post_id, presence: true
  # validates :customer_id, presence: true
   #, uniqueness: 
   
   validates :customer_id, uniqueness: { scope: :post_id} 

   belongs_to :post#, optional: true
   belongs_to :customer, optional: true


    def bookmarks(customer)
      bookmarks.where(customer_id: customer.id).exists?
    end


def  bookmarked_by?(customer)
#現在ログインしているユーザーによっていいねされてる？
    bookmarks.exists?(customer_id: customer.id)
#いいねは存在してる？(いいねを既に押してるか、押していないか)
end


end
