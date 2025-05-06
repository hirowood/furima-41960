# app/models/address_order.rb
class AddressOrder
  include ActiveModel::Model

  # ------------------------
  # 属性
  # ------------------------
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :house_number, :building_name, :phone_number,
                :token

  # ------------------------
  # 定数（正規表現は i オプション不要なので削除 & .freeze で凍結）
  # ------------------------
  VALID_PHONE_NUMBER_REGEX  = /\A\d{10,11}\z/
  VALID_POSTAL_CODE_REGEX   = /\A\d{3}-\d{4}\z/

  # ------------------------
  # バリデーション
  # ------------------------
  with_options presence: true do
    validates :user_id,
              :item_id,
              :city,
              :house_number,
              :token

    validates :postal_code,
              format: { with: VALID_POSTAL_CODE_REGEX,
                        message: 'is invalid. Use format 123-4567' }

    validates :phone_number,
              format: { with: VALID_PHONE_NUMBER_REGEX,
                        message: 'must be 10〜11 桁の半角数字のみ' }
  end

  validates :prefecture_id,
            numericality: { other_than: 0, message: "can't be blank" }

  # ------------------------
  # 保存処理
  # ------------------------
  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(item_id: item_id, user_id: user_id)

      Address.create!(
        order_id: order.id,
        user_id: user_id,
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        house_number: house_number,
        building_name: building_name,
        phone_number: phone_number
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
