# テーブル設計


## users テーブル

|   Column     |  Type  |   Options   |
| ------------ | ------ | ----------- |
| name         | string | null: false |
| email        | string | null: false, unique: true |
| password     | string | null: false |
| kanji_name   | string | null: false |
| kana_name    | string | null: false |
| phone_number | string | null: false |
| role         | int    | null: false, default: 0 |

- has_one :buyers
- has_one :sellers
- has_many :addresses

## buyers テーブル

|   Column     |  Type      |   Options                      |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| order        | references | null: false, foreign_key: true |

- belongs_to :user
- has_many   :orders

## sellersテーブル

|   Column     |  Type      |   Options                      |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |

- belongs_to :user
- has_many: items


## addressesテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true  |
| postal_code   | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| house_number  | string     | null: false |
| building_name | string     | null: false |

- belongs_to :user

## itemsテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| seller        | references | null: false, foreign_key: true |
| name          | string     | null: false |
| price         | integer    | null: false |
| description   | text       | null: false |
| status        | boolean    | null: false |
| order         | references | null: false, foreign_key: true |

- belongs_to :seller
- has_many: orders




## orderテーブル

|   Column      |  Type      |   Options                      |
| ------------- | ---------- | ------------------------------ |
| buyer         | references | null: false, foreign_key: true |
| item          | string     | null: false, foreign_key: true |
| status        | integer    | null: false, default: 0 |

- has_many :order
- has_many :item