class DeliveryDay < ActiveHash::Base
  self.data = YAML.file_load(Rails.root.join('db', 'fixtures', 'shopping_data'))[time_until_shipment]
  include ActiveHash::Associations
  has_many :items
end
