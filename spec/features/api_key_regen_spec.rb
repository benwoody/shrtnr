require 'spec_helper'

describe 'api_key regeneration' do
  let(:user) { create(:user) }

  before do
    login_as user
    visit settings_path
  end

  it 'should have a api_key regeneration button' do
    expect(page).to have_button 'API Key Regeneration'
  end
end
