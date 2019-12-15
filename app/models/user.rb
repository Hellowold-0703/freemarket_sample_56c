class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[facebook  google_oauth2]
         def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            user.first_name = auth.info.name
          end
        end

  has_many :sellers
  has_many :buyers
  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product
  has_many :credit_cards
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ZENKAKU_MOJI      = /\A[ぁ-んァ-ン一-龥]/
  ZENKAKU_KANA      = /\A([ァ-ン]|ー)+\z/
  PHONE_NUMBER      = /\A\d{10}\z|\A\d{11}\z/
  POST_NUMBER       = /\A\d{3}[-]\d{4}\z|^\d{3}[-]\d{2}\z|^\d{3}\z|^\d{5}\z|^\d{7}\z/

  ##indexのバリデーションチェック
  validates :nickname,                presence: true, length: {maximum: 20}, on: :validates1
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, on: :validates1
  validates :password,                presence: true, length: {minimum: 7, maximum: 128}, on: :validates1
  validates :password_confirmation,   presence: true, length: {minimum: 7, maximum: 128}, on: :validates1
  validates :first_name,              presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_MOJI }, on: :validates1
  validates :famliy_name,              presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_MOJI }, on: :validates1
  validates :first_furigana,          presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_KANA }, on: :validates1
  validates :family_furigana,         presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_KANA }, on: :validates1
  validates :birth_year,          presence: true, on: :validates1
  validates :birth_month,         presence: true, on: :validates1
  validates :birth_day,           presence: true, on: :validates1

  #phone_numberのバリデーションチェック
  validates :phone_number,            presence: true, uniqueness: true, format: { with: PHONE_NUMBER }, on: :validates2

  #addressのバリデーションチェック
  validates  :address_first_name,     presence: true, on: :validates3
  validates  :address_last_name_kana, presence: true, on: :validates3
  validates  :address_number,         presence: true, on: :validates3
  validates  :address_prefecture,     presence: true, on: :validates3
  validates  :address_name,           presence: true, on: :validates3
  validates  :address_block,          presence: true, on: :validates3
  
  
  ##creditのバリデーションチェック
  validates  :card_number,                 presence: true, on: :validates4
  validates  :payment_carc_expire,         presence: true, on: :validates4
  validates  :payment_card_security_code,  presence: true, on: :validates4
  validates  :exp_month,                   presence: true, on: :validates4
  validates  :exp_year,                    presence: true, on: :validates4

end
