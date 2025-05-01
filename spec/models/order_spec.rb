require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user: @user, item: @item)
  end

  describe 'バリデーション' do
    context '注文が有効な場合' do
      it '全ての情報が正しく入力されていれば有効である' do
        expect(@order).to be_valid
      end
    end

    context '注文が無効な場合' do
      it 'ユーザーが紐付いていないと無効である' do
        @order.user = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('User must exist')
      end

      it '商品が紐付いていないと無効である' do
        @order.item = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('Item must exist')
      end
    end
  end
end
