class User
  include Mongoid::Document
  # include Mongoid::MagicCounterCache
  Mongoid.raise_not_found_error = false
  include ActiveModel::SecurePassword

  field :name, type: String
  field :email, type: String
  field :motto, type: String
  field :status, type: String
  field :remember_token, type: String
  field :active_code, type: String
  field :is_actived, type: Boolean
  field :admin, type: Boolean
  field :join_time, type: DateTime
  field :sex, type: String
  field :blog, type: String
  field :battle_count, type: Integer, default: -> { 0 }
  field :win_times, type: Integer, default: -> { 0 }
  field :fail_times, type: Integer, default: -> { 0 }
  field :score, type: Integer, default: -> { 1500 }
  field :draw_times, type: Integer, default: -> { 0 }

  field :password_digest, type: String

  has_and_belongs_to_many :following, class_name: 'User'
  has_and_belongs_to_many :follower, class_name: 'User'

  has_and_belongs_to_many :matches

  has_and_belongs_to_many :battles, class_name: 'Battle', inverse_of: :users
  # counter_cache :battles
  
  has_and_belongs_to_many :stareds, class_name: 'Battle', inverse_of: :starers

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

  private

    def create_remember_token
      self.remember_token = User.hash_custom(User.new_remember_token)
    end
end
