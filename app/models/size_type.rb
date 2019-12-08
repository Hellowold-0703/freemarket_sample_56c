class SizeType < ApplicationRecord
  has_many :sizes
  has_many :category_id
end
