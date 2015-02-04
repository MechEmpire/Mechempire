json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :motto, :avarar_address
  json.url user_url(user, format: :json)
end
