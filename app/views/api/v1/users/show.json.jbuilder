
json.user do |json|
	json.name @user.name
	json.email @user.email
	json.links @user.links, :short_url, :long_url, :clicks
end


