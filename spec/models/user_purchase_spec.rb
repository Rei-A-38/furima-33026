require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user) # 購買者
      item = FactoryBot.create(:item)
      @user_purchase = FactoryBot.build(:user_purchase, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    describe '商品購入機能' do
      context '保存できる場合' do
        it '正常なデータがあれば登録できる' do
          expect(@user_purchase).to be_valid
        end

        it 'buildig_nameは空でも保存できること' do
          @user_purchase.building_name = nil
          expect(@user_purchase).to be_valid
        end
      end

      context '保存できない場合' do
        it 'postal_codeが空だと保存できないこと' do
          @user_purchase.postal_code = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("Postal code can't be blank")
        end

        it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
          @user_purchase.postal_code = '1234567'
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include('Postal code はハイフンを入れてください')
        end

        it 'prefectureを選択していないと保存できないこと' do
          @user_purchase.prefecture_id = 1
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include('Prefecture を１つ選んでください')
        end

        it 'prefectureが空だと保存できないこと' do
          @user_purchase.prefecture_id = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("Prefecture can't be blank")
        end

        it 'cityを選択していないと保存できないこと' do
          @user_purchase.city = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("City can't be blank", 'City は全角文字を使用して下さい')
        end

        it 'house_numberが空だと保存できないこと' do
          @user_purchase.house_number = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("House number can't be blank")
        end

        it 'phone_numberが空だと保存できないこと' do
          @user_purchase.phone_number = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("Phone number can't be blank")
        end

        it 'phone_numberにハイフンが含まれていると保存できないこと' do
          @user_purchase.phone_number = '123-456-890'
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include('Phone number は数字のみ入力してください')
        end

        it 'phone_numberが数字以外だと保存できないこと' do
          @user_purchase.phone_number = 'あああああ'
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include('Phone number は数字のみ入力してください')
        end

        it 'phone_numberが12桁以上だと保存できないこと' do
          @user_purchase.phone_number = '123456789012'
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include('Phone number は数字のみ入力してください')
        end

        it 'tokenが空では登録できないこと' do
          @user_purchase.token = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("Token can't be blank")
        end

        it 'user_idが空では登録できないこと' do
          @user_purchase.user_id = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("User can't be blank")
        end

        it 'item_idが空では登録できないこと' do
          @user_purchase.item_id = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("Item can't be blank")
        end
      end
    end
  end
end
