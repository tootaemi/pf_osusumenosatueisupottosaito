class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :validatable,:rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,:rememberable
end