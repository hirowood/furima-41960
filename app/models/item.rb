class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :prefecture
  belongs_to :product_condition
  belongs_to :delivery_day
  belongs_to :free_shopping

  VALID_PRICE_REGEX = /\A[0-9]+\z/

  with_options presence: true do
    validates :name
    validates :price, format: { with: VALID_PRICE_REGEX },
                      numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :description
  end

  with_options numericality: { other_than: 1 } do
    validates :product_condition_id
    validates :prefecture_id
    validates :genre_id
    validates :free_shopping_id
    validates :delivery_day_id
  end
end
