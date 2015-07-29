json.shorturl @link.short_url
json.(@link, :long_url, :clicks)
json.user do
  json.email @link.user.name
  json.name @link.user.email
end
