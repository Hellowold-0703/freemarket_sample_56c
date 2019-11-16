class Product < ApplicationRecord

  mount_uploaders :images, ImageUploader
  serialize :images, JSON

  has_many :sellers
  has_many :buyers

  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  
end
