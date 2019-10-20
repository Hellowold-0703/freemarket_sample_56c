# データベース設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|email|string|null: false, foreign_key: true|
|password|string|null: false, foreign_key: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_furigana|string|null: false|
|first_furigana|string|null: false|
|birth_year|string|null: false|
|profile|text||
|image|string||
|product_id|integer|null: false, foreign_key: true|
|phone_number|string|unique: true|
|address_id|integer|null: false, foreign_key: true|

### Association
- has_one :users_address

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
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
|size_id|integer|null: false, foreign_key: true|
|image|text|null: false, index: true|
|name|text|null: false|
|explanation|text|null: false|
|status|string|null: false|
|skipping charge|string|null: false|
|skipping area|string|null: false|
|days before skipment|string|null: false|
|selling prime|integer|null: false|
|skipping method|string|null: false|
|like number|integer||

### Association
- belongs_to :user
- belongs_to :brand

## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

- has_many :products


### Association
- 


## categorysテーブル

|Column|Type|Options|
|------|----|-------|
||integer|null: false, foreign_key: true|

### Association
- has_many :brands, though: :categorys_brand

## sizesテーブル

|Column|Type|Options|
|------|----|-------|

### Association






## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
|contents|text|null: false|


### Association
- belongs_to :user
- belongs_to :product


## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :product


