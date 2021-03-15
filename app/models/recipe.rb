class Recipe < ContentfulModel::Base
  self.content_type_id = "recipe"

  has_many :tags
  has_one :chef
end