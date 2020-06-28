class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :instructions, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :instructions, allow_destroy: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 5.megabytes,
                                    message: "should be less than 5MB" }

  def display_image_200
    image.variant(resize_to_limit: [200, 200])
  end

  def display_image_400
    image.variant(resize_to_limit: [400, 400])
  end

end