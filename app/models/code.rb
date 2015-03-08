class Code
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  field :path, String
  field :status, String
  field :create_at, DateTime
  field :update_times, Integer
  
  belongs_to :mech
end