json.user do
  json.name @user.name
  json.email @user.email
  json.links @user.links, partial: 'link', as: :link
end
