class Category < ApplicationRecord
  has_ancestry
  has_many :products
  belongs_to :size_type, optional: true
end
