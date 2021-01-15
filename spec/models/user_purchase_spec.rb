require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '購入情報の保存' do
    before do
      
      user = FactoryBot.create(:user) #購買者
      item = FactoryBot.create(:item)
      @user_purchase = FactoryBot.build(:user_purchase, user_id: user.id , item_id: item.id)
      sleep 0.1
    end

    describe '商品購入機能' do
      context '保存できる場合' do
       it '正常なデータがあれば登録できる' do
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
          expect(@user_purchase.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
        end

        it 'prefectureを選択していないと保存できないこと' do
          @user_purchase.prefecture_id = 1
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("Prefecture must be other than 1")
        end

        it 'cityを選択していないと保存できないこと' do
          @user_purchase.city = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("City can't be blank")
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
          # binding.pry
          expect(@user_purchase.errors.full_messages).to include("Phone number input only number")
        end

        it "tokenが空では登録できないこと" do
          @user_purchase.token = nil
          @user_purchase.valid?
          expect(@user_purchase.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
end

