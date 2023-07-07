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

users テーブル
ユーザー情報を管理するテーブル

カラム名	データ型	制約
id	integer	PRIMARY KEY
username	string	NOT NULL
email	string	NOT NULL
password_digest	string	NOT NULL
created_at	datetime	
updated_at	datetime	

products テーブル
商品情報を管理するテーブル

カラム名	データ型	制約
id	integer	PRIMARY KEY
name	string	NOT NULL
description	text	
price	integer	NOT NULL
user_id	integer	FOREIGN KEY
created_at	datetime	
updated_at	datetime	
orders テーブル
商品の購入情報を管理するテーブル

カラム名	データ型	制約
id	integer	PRIMARY KEY
user_id	integer	FOREIGN KEY
product_id	integer	FOREIGN KEY
quantity	integer	NOT NULL
created_at	datetime	
updated_at	datetime	
テーブル間の関連
users テーブルと products テーブルは1対多の関係であり、users.id が products.user_id に関連付けられています。
users テーブルと orders テーブルも1対多の関係であり、users.id が orders.user_id に関連付けられています。
products テーブルと orders テーブルも1対多の関係であり、products.id が orders.product_id に関連付けられています。
