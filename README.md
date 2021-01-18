## users テーブル

| Column               | Type    | Options     |
| -------------------- | --------| ----------- |
| email                | string  | null: false |
| encrypted_password   | string  | null: false |
| nickname             | string  | null: false |
| kanji_sei            | string  | null: false |
| kanji_mei            | string  | null: false |
| katakana_sei         | string  | null: false |
| katakana_mei         | string  | null: false |
| birthday             | date    | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column             | Type           | Options           |
| ------------------ | -------------- | ----------------- |
| title              | string         | null: false       |
| detail             | text           | null: false       |
| category_id        | integer        | null: false       |
| condition_id       | integer        | null: false       |
| shipping_fee_id    | integer        | null: false       |
| prefecture_id      | integer        | null: false       |
| delivery_time_id   | integer        | null: false       |
| price              | integer        | null: false       |
| user_id            | integer        | foreign_key: true |


### Association

- belongs_to :user
- has_one : purchase

## purchases テーブル

| Column       | Type            | Options           |
| ------------ | --------------  | ----------------- |
| user_id      | integer         | foreign_key: true |
| item_id      | integer         | foreign_key: true |

### Association

- has_one :address
- belongs_to :user
- belongs_to :item


## addresses テーブル

| Column          | Type          | Options           |
| --------------- | ------------- | ----------------- |
| prefecture_id   | integer       | null: false       |
| postal_code     | string        | null: false       |
| city            | string        | null: false       |
| house_number    | string        | null: false       |
| building_name   | string        | 
| phone_number    | string        | null: false       |
| purchase        | references    | foreign_key: true |


### Association

- belongs_to :purchase




