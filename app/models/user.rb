class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :motto, type: String
  field :avatar_address, type: String

  # index({})
end
