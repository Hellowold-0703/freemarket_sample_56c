class Product < ApplicationRecord

  mount_uploaders :image, ImageUploader
end
