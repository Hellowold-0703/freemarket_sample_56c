# データベース設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|email|string|null: false, foreign_key: true|
|password|string|null: false, foreign_key: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_furigana|string|null: false|
|first_furigana|string|null: false|
|birth_year|string|null: false|
|profile|text||
|image|string||
|phone_number|string|unique: true|

### Association
- has_one :users_address
- has_one :users_authentication
- has_many :credit_cards
- has_many :comments
- has_many :likes
- has_many :reviews
- has_many :byers
- has_many :sellers


## users_addressテーブル

|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building|string|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## users_authenticationテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|phone_number|string|unique: true, foreign_key: true|

### Association
- belongs_to :user


## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|
|name|text|null: false|
|explanation|text|null: false|
|status|string|null: false|
|shipping_charge|string|null: false|
|shipping_area|string|null: false|
|days_before_shipment|string|null: false|
|selling_price|integer|null: false|
|shipping_method|string|null: false|

### Association
- belongs_to :category
- belongs_to :brand
- belongs_to :category
- belongs_to :size
- has_many :comments
- has_many :reviews
- has_many :byers
- has_many :sellers
- has_many :product_images

## product_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|binary|null: false, index: true|
|name|string|null: false|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :product

## byersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product


## sellersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :products


### categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|size_type_id|references|null: false, foreign_key: true|

### Association
- has_many :products
- belongs_to :size_type

## sizesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|size_type_id|references|null: false, foreign_key: true|

### Association
- has_many :items
- belongs_to :size_type


## size_typesテーブル

|Column|Type|Options|
|------|----|-------|
|size_type|string|null: fals|

### Association
- has_many :sizes
- has_many :category_id


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|
|content|text|null: false|

### Association
- belongs_to :user
- belongs_to :product


## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product


## reviewsテーブル

|Column|Type|Options|
|------|----|-------|
|rate|integer|null: false|
|comment|text||
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product# freemarket_sample_56c_test
