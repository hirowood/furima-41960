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

- has_many :items
- has_many :orders


## addressesテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| order_id      | references | null: false, foreign_key: true  |
| postal_code   | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| house_number  | string     | null: false |
| building_name | string     | null: true |
| phone_number  | string     | null: false |

- belongs_to :order

## itemsテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| user_id       | references | null: false, foreign_key: true |
| genre_id      | integer    | null: false |
| name          | string     | null: false |
| price         | integer    | null: false |
| description   | text       | null: false |

- belongs_to :user
- has_one: order




## orderテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| user_id       | references | null: false, foreign_key: true |
| item_id       | string     | null: false, foreign_key: true |
| status        | integer    | null: false, default: 0 |

- has_many :orders
- has_many :items
- has_one :address