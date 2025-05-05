# app/models/address_order.rb
class AddressOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :house_number, :building_name, :phone_number,
                :token

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/i
  VALID_PHONE_NUMBER_REGEX.freeze
  VALID_POSTAL_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/i
  VALID_POSTAL_CODE_REGEX.feeze

  with_options presence: true do
    validates :user_id, :item_id, :city, :house_number, :token
    validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number,
              format: { with: VALID_PHONE_NUMBER_REGEX, message: 'PhoneNumber must be 10or11 digit Half-width numbers' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  end

  def save
    return false unless valid?

    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(
      order_id: order.id,
      user_id: user_id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      house_number: house_number,
      building_name: building_name,
      phone_number: phone_number
    )
    true
  end
end
