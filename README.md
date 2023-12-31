
## users テーブル
ユーザー情報を管理するテーブル

| Column                     | Type    | Options                                 |
|----------------------------|---------|-----------------------------------------|
| nickname                   | string  | null: false                             |
| email                      | string  | null: false, unique： true              |
| encrypted_password         | string  | null: false                             |
| first_name                 | string  | null: false                             |
| last_name                  | string  | null: false                             |
| first_name_kana            | string  | null: false                             |
| last_name_kana             | string  | null: false                             |
| birthday                   | date    | null: false                             |

### Association
has_many :items
has_many :orders

## items テーブル
商品情報を管理するテーブル

| Column               | Type      | Options                                  |
|----------------------|-----------|------------------------------------------|
| name                 | string    | null: false                              |
| explanation          | text      | null: false                              |
| price                | integer   | null: false                              |
| user                 | references| null: false, foreign_key: true           |
| condition_id         | integer   | null: false                              |
| prefecture_id        | integer   | null: false                              |
| shopping_fee_id      | integer   | null: false                              |
| shopping_duration_id | integer   | null: false                              |
| category_id          | integer   | null: false                              |



### Association
belongs_to :user
has_one :order


## orders テーブル
商品の購入情報を管理するテーブル

| Column             | Type         | Options                             |
|--------------------|--------------|-------------------------------------|
| item               | references   | null: false, foreign_key: true      |
| user               | references   | null: false, foreign_key: true      |

### Association
belongs_to :user
belongs_to :item
has_one :address


## addressesテーブル
発送先住所を管理するテーブル

| Column           | Type        | Options                        |
|------------------|-------------|--------------------------------|
| postal_code      | string      | null: false                    |
| prefecture_id    | integer     | null: false                    |
| city             | string      | null: false                    |
| address           | string      | null: false                    |
| building         | string      |                                |
| phone_number     | string      | null: false                    |
| order            | references  | null: false, foreign_key: true |

 
### Association
belongs_to :order