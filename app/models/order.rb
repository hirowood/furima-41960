class Order < ApplicationRecord
  belongs_to :order
  belongs_to :item
  has_one :address
end
