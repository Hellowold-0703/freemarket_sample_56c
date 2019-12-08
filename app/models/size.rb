class Size < ApplicationRecord
  has_many :items
  belongs_to :size_type, optional: true
end
