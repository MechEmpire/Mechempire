class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :motto, type: String
  field :avatar_address, type: String

  # index({})

  def test
    puts redis_key(:following)
  end

  def redis_key(str)
    "user:#{self.id}:#{str}"
  end
end
