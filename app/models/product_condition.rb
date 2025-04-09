class ProductCondition < ActiveHash::Base
  self.data = YAML.file_load(Rails.root.join('db', 'fixtures', 'product_data.yml'))[product_condition]
  include ActiveHash::Associations
  has_many :items
end
