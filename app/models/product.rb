class Product < ApplicationRecord

  mount_uploaders :images, ImageUploader
  serialize :images, JSON

  has_many :sellers
  has_many :buyers
end
