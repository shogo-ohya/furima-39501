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

データベース設計

## users テーブル
ユーザー情報を管理するテーブル

| Column                     | Type    | Options                                 |
|----------------------------|---------|-----------------------------------------|
| nickname                   | string  | null: false                             |
| email                      | string  | UNIQUE                                  |
| encrypted_password         | string  | null: false                             |
| first_name                 | string  | null: false                             |
| last_name                  | string  | null: false                             |
| first_name_kana            | string  | null: false                             |
| last_name_kana             | string  | null: false                             |
| birthday                   | date    | null: false                                        |

### Association
has_many :items
has_many :orders

## items テーブル
商品情報を管理するテーブル

| Column            | Type      | Options                                  |
|-------------------|-----------|------------------------------------------|
| name              | string    | null: false                              |
| explanation       | text      |                                          |
| price             | integer   | null: false                              |
| user              | references| null: false, foreign_key: references users|
| condition_id      | datetime  |                                          |
| prefecture        | string    | null: false                              |

### Association
belong_to :user
has_many :order


## orders テーブル
商品の購入情報を管理するテーブル

| Column     | Type       | Options                             |
|------------|------------|-------------------------------------|
| item       | references | FOREIGN KEY REFERENCES items        |

### Association
belong_to :user
belong_to :item
has_one :addresses


## addressesテーブル
発送先住所を管理するテーブル

| Column           | Type       | Options                           |
|------------------|------------|-----------------------------------|
| user             | references | FOREIGN KEY REFERENCES users   |
| postal_code      | string     | null: false                    |
| prefecture       | string     | null: false                    |
| city             | string     | null: false                    |
| street           | string     | null: false                    |
| phone_number           | string     | null: false                    |
| first_name       | string     | null: false                    |
| last_name        | string     | null: false                    |
| first_name_kana  | string     | null: false                    |
| last_name_kana   | string     | null: false                    |
 
### Association
belong_to :oder