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
| username         | string  | NOT NULL                                |
| email            | string  | NOT NULL                                |
| password_digest  | string  | NOT NULL                                |
| created_at       | datetime|                                         |
| updated_at       | datetime|                                         |

### Association
has_many :items
has_many :orders
has_one :addresses

## items テーブル
商品情報を管理するテーブル

| Column      | Type    | Options                                 |
|-------------|---------|-----------------------------------------|
| id          | integer | PRIMARY KEY                             |
| name        | string  | NOT NULL                                |
| description | text    |                                         |
| price       | integer | NOT NULL                                |
| user_id     | integer | FOREIGN KEY REFERENCES users(id)        |
| created_at  | datetime|                                         |
| updated_at  | datetime|                                         |

### Association
belong_to :users
has_many :orders


## orders テーブル
商品の購入情報を管理するテーブル

| Column     | Type    | Options                                 |
|------------|---------|-----------------------------------------|
| id         | integer | PRIMARY KEY                             |
| user_id    | integer | FOREIGN KEY REFERENCES users(id)        |
| product_id | integer | FOREIGN KEY REFERENCES products(id)     |
| quantity   | integer | NOT NULL                                |
| created_at | datetime|                                         |
| updated_at | datetime|                                         |

### Association
belong_to :users
belong_to :items


## addressesテーブル
発送先住所を管理するテーブル

| Column       | Type    | Options                           |
|--------------|---------|-----------------------------------|
| id           | integer | PRIMARY KEY                       |
| user_id      | integer | FOREIGN KEY REFERENCES users(id)  |
| postal_code  | string  | NOT NULL                          |
| prefecture   | string  | NOT NULL                          |
| city         | string  | NOT NULL                          |
| street       | string  | NOT NULL                          |
| building     | string  |                                   |
| created_at   | datetime| NOT NULL                          |
| updated_at   | datetime| NOT NULL                          |

### Association
belong_to :users