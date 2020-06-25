class Recipe < ApplicationRecord
  belongs_to :user
  has_many :instructions, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :instructions, allow_destroy: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
end
