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
|product_id|references|null: false, foreign_key: true|
|phone_number|string|unique: true|
|address_id|references|null: false, foreign_key: true|

### Association
- has_one :users_address
- has_many :products
- has_many :comments
- has_many :likes
- has_many :reviews


## users_addressテーブル

|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false, foreign_key: true|
|prefecture|string|null: false, foreign_key: true|
|city|string|null: false, foreign_key: true|
|house_number|string|null: false, foreign_key: true|
|building|string|null: false, foreign_key: true|

### Association
- belongs_to :user


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|genre_id|references|null: false, foreign_key: true|
|small_genre_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|
|image|text|null: false, index: true|
|name|text|null: false|
|explanation|text|null: false|
|status|string|null: false|
|skipping charge|string|null: false|
|skipping area|string|null: false|
|days before skipment|string|null: false|
|selling prime|integer|null: false|
|skipping method|string|null: false|

### Association
- belongs_to :user
- belongs_to :genre
- belongs_to :small_genre
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


## genresテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|category_id|references|null: false, foreign_key: true|

### Association
- has_many :sizes, though: :sizes_genres
- has_many :small_genres
- belongs_to :category


## sizesテーブル

|Column|Type|Options|
|------|----|-------|
|value|string|null: false|

### Association
- has_many :genres, though: :sizes_genres


## sizes_genresテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||
|genre_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|

### Association
- belongs_to :genre
- belongs_to :size


## small_genresテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|genre_id|references|null: false, foreign_key: true|

### Association
- belongs_to :genre


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|
|contents|text|null: false|

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