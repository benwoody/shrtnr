# Test specification for user controller api version 1
require 'spec_helper'

describe Api::V1::UserController, type: :controller do
  let(:user) { create(:user) }

  describe '#show' do
    context 'using an invalid api key' do
      it 'returns a 401 code' do
        get :show, api_key: ' '
        expect(response.code).to eq '401'
      end
    end

    context 'using a valid api key' do
      let(:json) { JSON.parse(response.body) }
      before do
        get :show, api_key: user.api_key
      end

      it 'returns a json response with a user key' do
        expect(json['user']).not_to be_empty
      end

      it 'shows another test' do
        expect('1').to eq '1'
      end
    end
  end
end
