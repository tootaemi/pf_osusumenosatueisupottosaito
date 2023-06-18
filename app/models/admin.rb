class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
        # :recoverable, :validatable
        # :recoverable, :rememberable, :trackable, :validatable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable


  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :validatable




end
