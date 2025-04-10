class ProductCondition < ActiveHash::Base
  self.data = YAML.load_file(Rails.root.join('db', 'fixtures', 'product_detail_data.yml'))['product_condition']
  include ActiveHash::Associations
  has_many :items
end
