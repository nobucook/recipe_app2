class Ingredient < ApplicationRecord
  belongs_to :recipe
  # validates :recipe_id, presence: true
  validates :ingre, presence: true
  validates :amount, presence: true
  default_scope -> { order(id: :asc)}
end
