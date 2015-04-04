class Match
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  
  field :name, type: String
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  field :introduce, type: String
  field :owner, type: String
  has_many :battles
  has_many :users
  has_many :meches
end
