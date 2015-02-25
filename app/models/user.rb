class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  field :name, type: String
  field :email, type: String
  field :motto, type: String
  field :avatar_address, type: String
  field :password_digest, type: String
  field :password_confirmation, type: String
  field :password, type: String

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: {case_sensitive: false}
    
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  index({ email: 1 })

  before_save{ self.email = email.downcase }
  
  def test
    puts redis_key(:following)
  end

  def redis_key(str)
    "user:#{self.id}:#{str}"
  end
end
