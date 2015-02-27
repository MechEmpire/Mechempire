class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  field :name, type: String
  field :email, type: String
  field :motto, type: String
  field :remember_token, type: String
  # field :avatar_address, type: String
  field :password_digest, type: String
  # field :password_confirmation, type: String
  # field :password, type: String
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { maximum: 50 }
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: {case_sensitive: false}
    
  validates :password, presence: true, 
                       length: { minimum: 6 },
                       if: :password
  
  index({ email: 1, remember_token: 1 })

  before_save{ self.email = email.downcase }
  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end

  def test
    puts redis_key(:following)
  end

  def redis_key(str)
    "user:#{self.id}:#{str}"
  end
end
