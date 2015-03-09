class Mech
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  field :create_at, type: DateTime # mech create time
  field :carrier_id, type: String
  field :weapon_id, type: String

  belongs_to :user
  belongs_to :weapon
  belongs_to :carrier

  has_one :code
end