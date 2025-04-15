class DeliveryDay < ActiveHash::Base
  self.data = YAML.load_file(Rails.root.join('db', 'fixtures', 'shopping_data.yml'))['time_until_shipment']
  include ActiveHash::Associations
  has_many :items
end
