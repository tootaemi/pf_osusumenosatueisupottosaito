class Post < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  
   has_one_attached :image
  has_many :customers, dependent: :destroy
  has_many :tags, dependent: :destroy
  
  belongs_to :customer, optional: true
  
  
  # has_one_attached :dish_image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy
  
  
  
  
  
  
    has_many :user_id, dependent: :destroy
    has_many :post_id, dependent: :destroy
    has_many :comment_id, dependent: :destroy
  
  
end