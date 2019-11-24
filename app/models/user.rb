class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[facebook  google_oauth2]
         def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
          end
        end

  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_furigana, presence: true
  validates :first_furigana, presence: true
  validates :birth_year, presence: true

  has_many :sellers
  has_many :buyers
  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product
end
