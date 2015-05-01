
param = { long_url: params[:url] }
@link = @user.links.build(param)
json.shorturl full_url(@link)
json.(@link, :long_url, :clicks)
json.user do |json|
	json.name @link.user.name
	json.email @link.user.email
end