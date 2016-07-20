json.array!(@accounts) do |account|
  json.extract! account, :id, :title, :username, :password, :url
  json.url post_url(account, format: :json)
end
