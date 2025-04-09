class FreeShopping < ActiveHash::Base
  self.data = YAML.file_load(Rails.root.join('db', 'fixtures', 'shopping_data.yml'))[shopping_load]
  include ActiveHash::Associations
  has_many :items
end
