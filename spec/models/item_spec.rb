require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '内容に問題がない場合' do
      it 'すべての値が入力されていれば保存できること' do
        expect(@item).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '商品画像が空だと保存できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空だと保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空だと保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'ジャンルを選択していないと保存できない' do
        @item.genre_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Genre must be other than 0')
      end

      it '配送料の負担を選択を選択していないと保存できない' do
        @item.free_shopping_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Free shopping must be other than 0')
      end

      it '発送元の地域を選択していないと保存できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it '発送までの日数を選択していないと保存できない' do
        @item.delivery_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery day must be other than 0')
      end

      it '販売価格を設定していないとき' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格が数値以外の時' do
        @item.price = 'aaaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格が300未満だと保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '販売価格が9999999より大きいと保存できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'userと紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it 'ジャンルに「---」が選択されている場合は出品できない' do
        @item.genre_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Genre must be other than 0')
      end

      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.product_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Product condition must be other than 0')
      end

      it '地域に「---」が選択されている場合は出品できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.free_shopping_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Free shopping must be other than 0')
      end

      it '配送にかかる日数に「---」が選択されている場合は出品できない' do
        @item.delivery_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery day must be other than 0')
      end
    end
  end
end
