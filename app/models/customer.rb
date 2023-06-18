class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable


  # devise :database_authenticatable, :registerable,
        # :recoverable, :rememberable, :validatablerememberable
        # :recoverable, :trackable, :validatable
  # include DeviseTokenAuth::Concerns::Customer

    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable
         
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable


  # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :trackable, :validatable, :rememberable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one :image, dependent: :destroy
  # belongs_to :post
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  # has_many :posts, dependent: :destroy
  # has_many :bookmarks, dependent: :destroy

 # ここからが他のモデルとの関係性
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # userのidを入れて、bookmarksメソッドを入れて、それぞれのpostを出す
  # 下記の記述はuser.bookmarks.map(&:post)これをしているのと一緒
  has_many :bookmark_posts, through: :bookmarks, source: :post


  def self.guest
    find_or_create_by(email: "test@com") do |customer|
      customer.password =  SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
      customer.password_confirmation = customer.password
      customer.name = 'ゲストユーザー'
      customer.email = 'test@test.com'
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

  # 引数に渡されたboardがブックマークされているか？
  def bookmark?(post)
    bookmark_posts.include?(post)
  end

def bookmarked_by?(post_id)
  bookmarks.where(post_id: post_id).exists?
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

end
