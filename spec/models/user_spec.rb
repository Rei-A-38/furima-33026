require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '保存できる場合' do
      it '正常なデータがあれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '保存できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは＠がなければ登録できない' do
        @user.email = 'wwwgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが存在しても半角英数字混合でなければ登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定して下さい')
      end

      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが存在しても数字だけでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定して下さい')
      end

      it 'passwordが存在しても全角では登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角文字を使用して下さい')
      end

      it '姓がないと登録できない' do
        @user.kanji_sei = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji sei can't be blank", 'Kanji sei には全角文字を使用して下さい')
      end

      it '名がないと登録できない' do
        @user.kanji_mei = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji mei can't be blank")
      end

      it '姓は全角でないと登録できない' do
        @user.kanji_sei = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji sei には全角文字を使用して下さい')
      end

      it '名は全角でないと登録できない' do
        @user.kanji_mei = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji mei には全角文字を使用して下さい')
      end

      it 'フリガナ（姓）が空だと登録できない' do
        @user.katakana_sei = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana sei can't be blank")
      end

      it 'フリガナ（名）が空だと登録できない' do
        @user.katakana_mei = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana mei can't be blank")
      end

      it '姓のフリガナは全角カタカナで無いと登録できない' do
        @user.katakana_sei = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('Katakana sei をカタカナで入力して下さい')
      end

      it '名のフリガナは全角カタカナで無いと登録できない' do
        @user.katakana_mei = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include('Katakana mei をカタカナで入力して下さい')
      end

      it '生年月日が無いと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
