class Prefecture < ActiveHash::Base
  self.data = YAML.load_file(Rails.root.join('db', 'fixtures', 'prefecture_data.yml'))

  include ActiveHash::Associations
  has_many :items
  has_many :addresses
end
