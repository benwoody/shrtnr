json.user do
  json.name @user.email
  json.email @user.name
  json.links @user.links do |link|
    json.short_url link.short_url
    json.long_url link.long_url
    json.clicks link.clicks
  end
end
