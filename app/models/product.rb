class Product < ApplicationRecord

  mount_uploaders :images, ImageUploader
  serialize :images, JSON

  has_many :sellers
  has_many :buyers
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  validates :category_id, presence: true
  
end
