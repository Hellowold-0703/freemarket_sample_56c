# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

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

### Association
- belongs_to :group
- belongs_to :user

## テーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user