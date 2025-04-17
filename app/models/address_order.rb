class AddressOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :address, :building, :phone_number

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  VALID_POSTAL_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/

  with_options presence: true do
    validates :user_id, :item_id, :city, :address
    validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number,
              format: { with: VALID_PHONE_NUMBER_REGEX, message: 'PhoneNumber must be 10or11 digit Half-width numbers' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  end

  def save
    return false unless valid?

    Order.create(item_id: item_id, user_id: user_id)
    Address.create(
      order_id: order.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number
    )

    true
  end
end
