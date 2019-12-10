class ProductImage < ApplicationRecord
  mount_uploader :product_image, ImageUploader
  belongs_to :product, optional: true
end
