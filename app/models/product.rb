class Product < ApplicationRecord

  mount_uploaders :images, ImageUploader
  serialize :images, JSON

  belongs_to :user
  has_many :sellers
  has_many :buyers
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  validates :name, presence: true
  validates :explanation, presence: true
  validates :status, presence: true
  validates :shipping_charge, presence: true
  validates :shipping_area, presence: true
  validates :days_before_shipment, presence: true
  validates :selling_prime, presence: true
  validates :shipping_method, presence: true
  validates :images, presence: true
  validates :category_id, presence: true

  
end
