require 'spec_helper'

describe 'creating a short url' do
  context 'when not signed in' do
  end

  context 'when signed in' do
    let(:user) { create(:user) }

    before do
      login_as user
    end
  end
end
