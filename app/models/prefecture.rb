class Prefecture < ActiveHash::Base
  self.data = YAML.file_load(Rails.root.join('db', 'fixtures', 'prefecture.yml'))

  include ActiveHash::Associations
  has_many :items
end
