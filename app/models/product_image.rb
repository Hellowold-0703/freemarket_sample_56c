class ProductImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :product, optional: true
end
