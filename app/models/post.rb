class Post < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  
  
   has_one_attached :images
  has_many :customers
  has_many :tags
  
  belongs_to :customers, optional: true
  
  end