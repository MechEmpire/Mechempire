class Mech
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  field :name, type: String
  field :weapon, type: String
  belongs_to :user
end