class User
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  include ActiveModel::SecurePassword
  field :name, type: String
  field :email, type: String
  field :motto, type: String
  field :remember_token, type: String
  field :active_code, type: String
  field :is_actived, type: Boolean
  field :admin, type: Boolean
  field :join_time, type: DateTime
  # field :avatar_address, type: String
  field :password_digest, type: String
  # field :password_confirmation, type: String
  # field :password, type: String

  # has_and_belongs_to_many :battles
  has_and_belongs_to_many :battles
  has_many :meches
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

  def User.hash_custom(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def meches_per_page(page)
    self.meches.order("create_at DESC").page(page).per(2)
  end

  def battle_count
    sum = 0
    self.meches.each do |mech|
      sum = sum + mech.battles.count
    end
    return sum
  end

  private

    def create_remember_token
      self.remember_token = User.hash_custom(User.new_remember_token)
    end

  # def test
  #   puts redis_key(:following)
  # end

  # def redis_key(str)
  #   "user:#{self.id}:#{str}"
  # end
end
