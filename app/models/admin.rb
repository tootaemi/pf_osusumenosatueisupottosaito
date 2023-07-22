class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :validatable,:rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,:rememberable
         
           
  # validates :name, presence: true
  # validates :email, presence: true
  # validates :password, presence: true, length: { maximum: 255 }
    
end