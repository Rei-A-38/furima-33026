require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報入力' do
    context '出品できる場合' do
      it '正常なデータがあれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'titleが空だと出品できない' do
        @item.title = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it 'detailが空だと出品できない' do
        @item.detail = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end

      it 'categoryが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を１つ選んでください')
      end

      it 'conditionが未選択だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition を１つ選んでください')
      end

      it 'shipping_feeが未選択だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee を１つ選んでください')
      end

      it 'prefectureが未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を１つ選んでください')
      end

      it 'delivery_timeが未選択だと出品できない' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery time を１つ選んでください')
      end

      it 'priceが空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字だと出品できない' do
        @item.price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price が正しくありません. 半角数字で入力してください')
      end

      it 'priceが全角漢字だと出品できない' do
        @item.price = '三三三三'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price が正しくありません. 半角数字で入力してください')
      end

      it 'priceが全角カタカナだと出品できない' do
        @item.price = 'アアアア'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price が正しくありません. 半角数字で入力してください')
      end

      it 'priceが全角英字だと出品できない' do
        @item.price = 'ａａａａ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price が正しくありません. 半角数字で入力してください')
      end

      it 'priceが半角英字だと出品できない' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price が正しくありません. 半角数字で入力してください')
      end

      it 'priceが300円以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price の設定が正しくありません')
      end

      it 'priceが9999999円以上だと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price の設定が正しくありません')
      end
    end
  end
end
