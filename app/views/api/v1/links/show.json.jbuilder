json.short_url full_url(@link)
json.(@link, :long_url, :clicks)
json.user do
  json.name @link.user.name
  json.email @link.user.email
end
