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
- has_many :products
- has_many :comments
- has_many :likes
- has_many :reviews


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


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|genre_id|references|null: false, foreign_key: true|
|small-genre_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|
|image|text|null: false, index: true|
|name|text|null: false|
|explanation|text|null: false|
|status|string|null: false|
|shipping_charge|string|null: false|
|shipping_area|string|null: false|
|days_before_shipment|string|null: false|
|selling_prime|integer|null: false|
|shipping_method|string|null: false|

### Association
- belongs_to :user
- belongs_to :genre
- belongs_to :small-genre
- belongs_to :brand
- belongs_to :category
- belongs_to :size
- has_many :comments
- has_many :reviews


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :products


### categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :products
- has_many :genres


## sizesテーブル

|Column|Type|Options|
|------|----|-------|
|value|string|null: false|

### Association
- has_many :genres, though: :sizes_small-genres


## sizes_small-genresテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||
|genre_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|

### Association
- belongs_to :small-genre
- belongs_to :size


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
- belongs_to :product