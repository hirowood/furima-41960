class Address < ApplicationRecord
  belongs_to :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  VALID_POSTAL_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/

  with_options presence: true do
    validates :city
    validates :phone_number,
              format: { with: VALID_PHONE_NUMBER_REGEX, message: 'PhoneNumber must be 10or11 digit Half-width numbers' }
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX, message: 'is invalid. Include hyphen(-)' }
  end
  validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }
end
