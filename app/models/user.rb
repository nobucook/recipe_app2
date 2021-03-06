class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :active_likes, class_name: "Like", foreign_key: "liker_id",
                  dependent: :destroy
  has_many :liking,
                  through: 'active_likes',
                  source: 'liked'
  attr_accessor :remember_token
  before_save {email.downcase!}
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
   update_attribute(:remember_digest, nil)
  end

  def like(recipe)
    liking << recipe
  end

  def unlike(recipe)
    self.active_likes.find_by(liked_id: recipe.id).destroy
  end

  def liking?(recipe)
    self.liking.include?(recipe)
  end
  

end
