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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  
  has_one :image, dependent: :destroy
  # belongs_to :post
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy


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

end

