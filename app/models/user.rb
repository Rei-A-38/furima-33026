class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定して下さい'

  PASSWORD_REGEX = /\A[\w@-]*[A-Za-z][\w@-]*\z/.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には半角文字を使用して下さい'

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'には全角文字を使用して下さい' } do
    validates :kanji_sei
    validates :kanji_mei
  end

  with_options presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'をカタカナで入力して下さい' } do
    validates :katakana_sei
    validates :katakana_mei
  end

  validates :birthday, presence: true

  has_many :items
end
