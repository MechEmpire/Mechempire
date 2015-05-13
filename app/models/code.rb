class Code
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  field :path, type: String
  field :status, type: String
  field :create_at, type: DateTime
  field :update_times, type: Integer
  
  belongs_to :mech
end