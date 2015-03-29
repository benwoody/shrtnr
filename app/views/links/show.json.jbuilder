json.short_url @link.short_url
json.user do |json|
  json.(@link.user, :id, :name)
end
