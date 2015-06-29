include SessionsHelper

def sign_in(user)
  allow(self.controller).to receive(:current_user).and_return(user)
end

def login_as(user)
  visit login_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'Password'
  click_button 'Login'
end

def sign_up_with(email, password, password_confirmation)
  visit "/users/new"
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password_confirmation
  click_button "Submit"
end
