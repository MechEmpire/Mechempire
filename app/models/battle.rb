class Battle
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  field :time,  type: DateTime
  field :result, type: String
  # has_and_belongs_to_many :meches
  # has_and_belongs_to_many :user
  has_one :attacker, class_name: "Mech", inverse_of: :attacked
  has_one :defender, class_name: "Mech", inverse_of: :defended
end