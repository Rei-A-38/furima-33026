## users テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| email      | string | null: false |
| password   | string | null: false |
| nickname   | string | null: false |
| kanji      | string | null: false |
| katakana   | string | null: false |
| birthday   | string | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column     | Type           | Options     |
| ---------- | -------------- | ----------- |
| title      | string         | null: false |
| detail     | text           | null: false |
| category   | text           | null: false |
| condition  | text           | null: false |
| price      | integer        | null: false |
| nickname   | string         | null: false |
| user_id    | string         | null: false |
| image      | ActiveStorage  | 


### Association

- belongs_to :addresses
- has one : purchases

## purchases テーブル

| Column       | Type           | Options     |
| -----------  | -------------- | ----------- |
| user_id      | string         | null: false |
| nickname     | string         | null: false |
| postal code  | integer        | null: false |
| city         | text           | null: false |
| house number | integer        | null: false |
| phone number | integer        | null: false |

### Association

- belongs_to :addresses
- belongs_to :items

## addresses テーブル

| Column       | Type           | Options     |
| -----------  | -------------- | ----------- |
| kanji name   | string         | null: false |
| postal code  | integer        | null: false |
| city         | text           | null: false |
| house number | integer        | null: false |
| phone number | integer        | null: false |

### Association

- belongs_to :purchases
- belongs_to :items


