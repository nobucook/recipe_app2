class Category < ApplicationRecord
  has_many :recipe_category_relations, dependent: :destroy
  has_many :recipes, through: "recipe_category_relations"
end
