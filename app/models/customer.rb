class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts
  has_one :image, dependent: :destroy
belongs_to :post

       
         
  # def self.guest
  #   find_or_create_by!(email: 'guest@example.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     user.password_confirmation = user.password
  #     user.name = "ゲストユーザー"
  #   end
  # end

    

         
  def self.guest
    find_or_create_by(email: "test@com") do |customer|
      customer.password =  SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
    end
  end
         
end
