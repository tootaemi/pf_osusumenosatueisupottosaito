class Customer < ApplicationRecord

  # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable

  # has_one :image, dependent: :destroy
  # belongs_to :post
  has_one_attached :image
  # has_many :post_comments, dependent: :destroy

 # ここからが他のモデルとの関係性
  has_many :posts#, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments#, dependent: :destroy

  # has_many :images, dependent: :destroy
  
   validates :image, presence: true
  validates :address, presence: true
  validates :hash_tags, presence: true
  
   validates :image, presence: true
  validates :address, presence: true
  validates :hash_tags, presence: true



#userオブジェクトのidとpostやlikeオブジェクトのuser_idが同じかどうかを判断
  def mine?(object)
   object.user_id == id
  end

#bookmarks_postsテーブルにpostオブジェクトを追加する。
#いいねを押したときに、いいねしたユーザーといいねされた投稿の情報が保存される。
 def bookmark(post)
   bookmarks.create(post_id: post.id)
 end

#likes_postsテーブルから引数のpostオブジェクトに該当するレコードを削除する。
 def unlike(post)
   bookmarks.find_by(post_id: post.id).destroy
 end

#likes_postsテーブルに引数のpostオブジェクトに該当するレコードがあるかを判断する。
 def bookmark?(post)
   bookmarks.where(post_id: post).exists?
 end

 def full_name
   "#{last_name} #{first_name}"
 end




  # userのidを入れて、bookmarksメソッドを入れて、それぞれのpostを出す
  # 下記の記述はuser.bookmarks.map(&:post)これをしているのと一緒
  # has_many :bookmarks, through: :bookmarks, source: :post


  # validates :customer_id, {presence: true}
  # def customers
  #   return Customer.find_by(id: self.customer_id)
  # end


# def self.guest
#     find_or_create_by!(name: "ゲストユーザー",
#                       email: "test@test.com",
#                       is_valid: true) do |customer|
#       user.password = SecureRandom.urlsafe_base64
#     end
# end






  def self.guest
    find_or_create_by(email: "test@test.com") do |customer|
      customer.password =  SecureRandom.urlsafe_base64
      customer.name = 'ゲストユーザー'
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end


  # 引数に渡されたものが、userのものであるか？
  def own?(object)
    id == bookmark?
  end



# # board_idを入れてブックマークしてください
#   def bookmark?(post)
#     # current_userがブックマークしているboardの配列にboardを入れる
#     bookmark_posts << @post
#   end

  # 引数のboardのidをもつ、レコードを削除してください
  def unbookmark(post)
    bookmark_posts.destroy(post)
  end



    def self.search(search) #self.はUser.を意味する
     if search
       where(['customername LIKE ?', "%#{search}%"]) #検索とuseanameの部分一致を表示。
     else
       all #全て表示させる
     end
    end





end