json.shorturl full_url(@link)
json.(@link, :long_url, :clicks)
json.user do
  json.email @link.user.email
  json.name @link.user.name
end
