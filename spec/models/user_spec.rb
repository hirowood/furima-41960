require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@user).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'nicknameが空だと保存できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'birth_dayが空だと保存できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
      it 'first_nameが空だと保存できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_kana_nameが空だと保存できないこと' do
        @user.first_kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana name can't be blank")
      end
      it 'last_nameが空だと保存できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_kana_nameが空だと保存できないこと' do
        @user.last_kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana name can't be blank")
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ)でないと保存できないこと' do
        @user.first_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ)でないと保存できないこと' do
        @user.last_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'first_kana_nameが全角カタカナでないと保存できないこと' do
        @user.first_kana_name = 'しまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First kana name is invalid. Input full-width katakana characters.')
      end
      it 'last_kana_nameが全角カタカナでないと保存できないこと' do
        @user.last_kana_name = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last kana name is invalid. Input full-width katakana characters.')
      end
      it 'passwordが空だと保存できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password_confirmationが空だと保存できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
      it 'emailが空だと保存できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it '重複したemailが存在すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'パスワードは、6文字以上での入力じゃないと保存できないこと' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードとパスワード（確認）は、値の一致していないと保存できない' do
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '英字のみだと無効' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors[:password]).to include('must include at least one letter and one digit, and only use half-width characters.')
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include('must include at least one letter and one digit, and only use half-width characters.')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード１'
        @user.valid?
        expect(@user.errors[:password]).to include('must include at least one letter and one digit, and only use half-width characters.')
      end
    end
  end
end
