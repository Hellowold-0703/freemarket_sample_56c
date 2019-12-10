class ProductImage < ApplicationRecord
  mount_uploader :product_images, ImageUploader
  belongs_to :product, optional: true
end
