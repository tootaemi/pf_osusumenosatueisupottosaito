class Post < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable


#   def was_attached?
#     self.image.attached?
#   end


#  has_many_attached :images
has_one_attached :image
#  belongs_to :user


#   def get_image
#     if image.attached?
#       image
#     else
#       'no_image.jpg'
#     end
#   end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_images.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

#   has_one_attached :image
  # has_many :tags, dependent: :destroy

  belongs_to :customer, optional: true


  # has_one_attached :dish_image
#   belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy


end