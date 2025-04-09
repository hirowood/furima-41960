class Genre < ActiveHash::Base
  self.data = YAML.load_file(Rails.root.join('db', 'fixtures', 'product_detail_data.yml'))[genre]

  include ActiveHash::Associations
  has_many :items
end
