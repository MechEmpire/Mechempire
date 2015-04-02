class Weapon
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  field :name, type: String
  field :damage, type: Integer
  field :speed, type: Integer
  field :cooling, type: Integer
  field :ammo, type: Integer
  field :introduce, type: String
  field :samplepic, type: String
  field :iden, type: String

  has_many :meches
  # belongs_to :mech
end