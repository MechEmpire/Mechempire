class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :motto, type: String
  field :avatar_address, type: String
  field :password, type: String

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true
  validates :password, presence: true

  # index({})

  def test
    puts redis_key(:following)
  end

  def redis_key(str)
    "user:#{self.id}:#{str}"
  end
end
