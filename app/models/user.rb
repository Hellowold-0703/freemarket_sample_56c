class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_furigana, presence: true
  validates :first_furigana, presence: true
  validates :birth_year, presence: true

  has_many :sellers
  has_many :buyers
  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product
end
