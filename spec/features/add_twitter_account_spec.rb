require 'spec_helper'

describe 'connecting to a twitter account' do
  context 'user has no link to twitter' do
    before do
      visit '/users/new'
      fill_in 'Email', with: 'test@one.com'
      fill_in 'Password', with: 'foobarfoo'
      fill_in 'Password confirmation', with: 'foobarfoo'
      click_button 'Submit'
    end

    it 'setting page contains a button to link twitter account' do
      visit '/settings'
      expect(page).to have_link('Link To Your Twitter Account')
    end

    it 'redirects user when button pushed' do
      visit '/settings'
      click_link 'Link To Your Twitter Account'
      expect(page).to have_content('Your Twitter account has been linked')
    end

    it 'links to twitter when button pushed' do
      visit '/settings'
      click_link 'Link To Your Twitter Account'
      expect(User.last.uid).not_to be_nil
    end
  end

  context 'user currently linked to twitter' do
    before do
      User.create name: 'Test One', email: 'test@one.com',\
                  password: '12345678', password_confirmation: '12345678',\
                  uid: '098765'
      visit '/login'
      fill_in 'Email', with: 'test@one.com'
      fill_in 'Password', with: '12345678'
      click_button 'Login'
    end

    after do
      User.last.destroy
    end

    it 'should not have a link to twitter button' do
      visit '/settings'
      expect(page).not_to have_link('Link To Your Twitter Account')
    end
  end
end
