class Item < ApplicationRecord
  belongs_to :user, through: :order
  has_one :order

  VALID_PRICE_REGEX = /\A[0-9]+\z/

  with_options presence: true do
    validates :name
    validates :price, format: { with: VALID_PRICE_REGEX },
                      numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :description
  end
end
