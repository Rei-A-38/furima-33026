class UserPurchase

  include ActiveModel::Model
  attr_accessor :token
  attr_accessor :user_id,:item_id,:prefecture_id,:postal_code,:city,:house_number,:building_name,:phone_number

  # バリデーションの記載(address,item_id,user_id)
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :prefecture_id,         numericality: { other_than: 1 }
    validates :postal_code,           format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city,                  format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "can't be blank" }
    validates :house_number         
    validates :phone_number,          format: { with: /\A\d{11}\z/, message: "input only number"}
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(prefecture_id: prefecture_id,postal_code: postal_code,city:city,house_number:house_number,building_name:building_name,phone_number: phone_number,purchase_id:purchase.id)
  end

end
