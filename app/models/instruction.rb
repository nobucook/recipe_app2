class Instruction < ApplicationRecord
  belongs_to :recipe
  default_scope -> { order(no: :asc)}
  # validates :recipe_id, presence: true
  validates :no, presence: true
  validates :how_to, presence: true

end
