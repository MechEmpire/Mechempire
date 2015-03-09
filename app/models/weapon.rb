class Weapon
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  field :name, type: String
  field :introduce, type: String
  field :samplepic, type: String

  has_many :meches
  # belongs_to :mech
end