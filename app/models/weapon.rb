class Weapon
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  field :name, type: String
  field :introduce, type: String

  belongs_to :mech
end