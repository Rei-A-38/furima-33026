class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_time

  validates :category, :condition, :delivery_time, :prefecture, :shipping_fee,  presence: true

  validates :category_id, :condition_id, :delivery_time_id, :prefecture_id, :shipping_fee_id, numericality: { other_than: 1 }

  validates :image,  presence: true 
  validates :title,  presence: true
  validates :detail, presence:true
  validates :price,  presence: true

  PASSWORD_REGEX = /\A[-]?[0-9]+(\.[0-9]+)?\z/.freeze
  validates_format_of :price, with: PASSWORD_REGEX, message: 'Half-width number'

  validates :price, numericality: { less_than_or_equal_to: 300, greater_than_or_equal_to: 9999999 , message: 'Out of setting range'}


  belongs_to :user
  has_one_attached :image
end
