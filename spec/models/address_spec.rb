require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe '購入機能' do
    context '全ての情報が有効な場合' do
      it '必須項目が全て存在すれば有効である' do
        expect(@address).to be_valid
      end
      it '建物名が空でも保存ができる' do
        @address.building_name = ''
        expect(@address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '市区町村が空だと無効である' do
        @address.city = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと無効である' do
        @address.house_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("House number can't be blank")
      end

      it '郵便番号が空だと無効である' do
        @address.postal_code = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '電話番号が空だと無効である' do
        @address.phone_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number can't be blank")
      end
    end

    context 'フォーマットが不正な場合' do
      it '郵便番号にハイフンがないと無効である' do
        @address.postal_code = '1234567'
        @address.valid?
        expect(@address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '郵便番号のフォーマットが間違っていると無効である' do
        @address.postal_code = '123-45678'
        @address.valid?
        expect(@address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '電話番号が10桁未満だと無効である' do
        @address.phone_number = '123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number PhoneNumber must be 10or11 digit Half-width numbers')
      end

      it '電話番号が11桁を超えると無効である' do
        @address.phone_number = '123456789012'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number PhoneNumber must be 10or11 digit Half-width numbers')
      end

      it '電話番号に数字以外の文字が含まれていると無効である' do
        @address.phone_number = '090-1234-5678'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number PhoneNumber must be 10or11 digit Half-width numbers')
      end
    end
  end
end
