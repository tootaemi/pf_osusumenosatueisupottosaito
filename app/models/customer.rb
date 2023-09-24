class Customer < ApplicationRecord

  # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2 }
  has_one_attached :image

  has_many :posts
  has_many :bookmarks, dependent: :destroy
  has_many :comments

  def mine?(object)
    object.user_id == id
  end

  def bookmark(post)
    bookmarks.create(post_id: post.id)
  end

  def unlike(post)
    bookmarks.find_by(post_id: post.id).destroy
  end

  def bookmark?(post)
    bookmarks.where(post_id: post).exists?
  end

  def self.guest
    find_or_create_by(email: "test@test.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲストユーザー"
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image
  end

  def own?(object)
    id == bookmark?
  end

  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  def self.search(search)
    if search
      where(["customername LIKE ?", "%#{search}%"])
    else
      all
    end
  end
end
