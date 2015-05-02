json.cache! ['v1', @links], expires_in: 1.hour do
  json.array!(@links) do |link|
    json.short_url link.short_url
    json.long_url link.long_url
    json.clicks link.clicks
    if link.user
      json.extract! link.user, :email
    end
  end
end
