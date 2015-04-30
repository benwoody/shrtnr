# Test specification for user controller api version 1
require 'spec_helper'

describe Api::V1::UsersController, type: :controller do
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
        get :show, api_key: user.api_key, id: user.id
      end

      it 'returns a JSON formated response' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns a json response with a content key' do
        expect(json.keys).not_to be_empty
      end

      it 'contains the user name' do
        expect(json.keys).to include 'name'
      end

      it 'contains the user email' do
        expect(json.keys).to include 'email'
      end

      it 'contains the user links' do
        expect(json.keys).to include 'links'
      end

      it 'returns the user name' do
        expect(json['name']).to include 'user'
      end

      it 'returns the user email' do
        expect(json['email']).to include '.com'
      end

      it 'returns the user links' do
        expect(json['links']).to be_kind_of(Array)
      end
    end
  end
end
