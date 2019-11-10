class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :sellers
  has_many :buyers
  has_many :products, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product
end
