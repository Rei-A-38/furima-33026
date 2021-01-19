class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_time

  validates :category, :condition, :delivery_time, :prefecture, :shipping_fee,  presence: true

  validates :category_id, :condition_id, :delivery_time_id, :prefecture_id, :shipping_fee_id,
            numericality: { other_than: 1, message: 'を１つ選んでください' }

  with_options presence: true do
    validates :image
    validates :title
    validates :detail
    validates :price
  end

  validates :price, numericality: { only_integer: true, message: 'が正しくありません. 半角数字で入力してください' }

  # PASSWORD_REGEX = /\A[-]?[0-9]+(\.[0-9]+)?\z/.freeze
  # validates_format_of :price, with: PASSWORD_REGEX, message: 'Half-width number'

  validates :price,
            numericality: { less_than_or_equal_to: 9_999_999, greater_than_or_equal_to: 300, message: 'の設定が正しくありません' }

  belongs_to :user
  has_one_attached :image
  has_one :purchase
end
