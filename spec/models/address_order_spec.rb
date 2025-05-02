# spec/models/address_order_spec.rb
require 'rails_helper'

RSpec.describe AddressOrder, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @address_order = FactoryBot.build(
      :address_order,
      user_id: @user.id,
      item_id: @item.id
    )
  end

  describe '購入情報の保存ができないとき' do
    it 'user_idが空では保存できない' do
      @address_order.user_id = nil
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では保存できない' do
      @address_order.item_id = nil
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("Item can't be blank")
    end

    it 'postal_codeが空では保存できない' do
      @address_order.postal_code = ''
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeがハイフンなしでは保存できない' do
      @address_order.postal_code = '1234567'
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'prefecture_idが0（"--"）では保存できない' do
      @address_order.prefecture_id = 0
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'cityが空では保存できない' do
      @address_order.city = ''
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("City can't be blank")
    end

    it 'house_numberが空では保存できない' do
      @address_order.house_number = ''
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("House number can't be blank")
    end

    it 'phone_numberが空では保存できない' do
      @address_order.phone_number = ''
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが9桁以下では保存できない' do
      @address_order.phone_number = '090123456'
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include('Phone number PhoneNumber must be 10or11 digit Half-width numbers')
    end

    it 'phone_numberが12桁以上では保存できない' do
      @address_order.phone_number = '090123456789'
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include('Phone number PhoneNumber must be 10or11 digit Half-width numbers')
    end

    it 'phone_numberが全角数字では保存できない' do
      @address_order.phone_number = '０９０１２３４５６７８'
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include('Phone number PhoneNumber must be 10or11 digit Half-width numbers')
    end

    it 'tokenが空では保存できない' do
      @address_order.token = nil
      @address_order.valid?
      expect(@address_order.errors.full_messages).to include("Token can't be blank")
    end
  end
end
