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

| Column           | Type    | Options                                 |
|------------------|---------|-----------------------------------------|
| id               | integer | PRIMARY KEY                             |
| nickname         | string  | NOT NULL                                |
| email            | string  | NOT NULL                                |
| password         | string  | NOT NULL                                |
| first_name       | string  |                                         |
| last_name        | string  |                                         |
| first_name_kana  | string  |                                         |
| last_name_kana   | string  |                                         |
| profile          | text    |                                         |
| birthday         | date    |                                         |
| image            | string  |                                         |

### Association
has_many :items
has_many :orders
has_one :addresses

## items テーブル
商品情報を管理するテーブル

| Column         | Type    | Options                                 |
|----------------|---------|-----------------------------------------|
| name           | string  | NOT NULL                                |
| explanation    | text    |                                         |
| price          | integer | NOT NULL                                |
| user_id        | integer | FOREIGN KEY REFERENCES users(id)        |
| condition_id   | datetime|                                         |
| size_id        | datetime|                                         |
|shopping_area_id|         |                                         |
|shopping_price  |         |                                         |
|shopping_date   |         |                                         |
|shopping_method_id|       |                                         |
|user_id         |         |                                         |
|category_id     |         |                                         |
|bland_id        |         |                                         |

### Association
belong_to :users
has_many :orders


## orders テーブル
商品の購入情報を管理するテーブル

| Column     | Type    | Options                                 |
|------------|---------|-----------------------------------------|
| user_id    | integer | FOREIGN KEY (user_id)        |
| item_id    | integer | FOREIGN KEY (item_id)     |

### Association
belong_to :users
belong_to :items


## addressesテーブル
発送先住所を管理するテーブル

| Column       | Type    | Options                           |
|--------------|---------|-----------------------------------|
| user_id      | integer | FOREIGN KEY REFERENCES users(id)  |
| postal_code  | string  | NOT NULL                          |
| prefecture   | string  | NOT NULL                          |
| city         | string  | NOT NULL                          |
| street       | string  | NOT NULL                          |
| building     | string  |                                   |

### Association
belong_to :users