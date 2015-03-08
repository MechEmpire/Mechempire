class Mech
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  field :create_at, type: DateTime # mech create time
  field :carrier_id, type: String
  field :weapon_id, type: String

  belongs_to :user

  # has_one :weapon
  has_one :code
  # has_one :carrer
end