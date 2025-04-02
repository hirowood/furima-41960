# テーブル設計


## users テーブル

|   Column           |  Type  |   Options   |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| kanji_name         | string | null: false |
| kana_name          | string | null: false |
| birth_day          | date   | null: false |

- has_many :items, through: :orders
- has_many :orders


## addressesテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| order         | references | null: false, foreign_key: true  |
| postal_code   | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| house_number  | string     | null: false |
| building_name | string     | null: true |
| phone_number  | string     | null: false |

- belongs_to :order

## itemsテーブル

|   Column         |  Type      |   Options                      |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| genre_id         | integer    | null: false |
| prefecture_id    | integer    | null: false |
| product_condition| integer    | null: false |
| free_shopping    | boolean    | null: false |
| delivery_days    | integer    | null: false |
| name             | string     | null: false |
| price            | integer    | null: false |
| description      | text       | null: false |

- belongs_to :user, through: :order
- has_one: :order




## ordersテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | string     | null: false, foreign_key: true |

- belongs_to :orders
- belongs_to :items
- has_one :address