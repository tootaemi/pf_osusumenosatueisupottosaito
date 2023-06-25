class Modele < ApplicationRecord
# Devise::Models::Rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
end