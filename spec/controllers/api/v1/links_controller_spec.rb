require 'spec_helper'

describe Api::V1::LinksController, type: :controller do
  let(:link) { create(:link) }
  let(:user) { create(:user) }

  describe '#create' do
    context 'with invalid api_key' do
      it 'returns a 401' do
        get :create, api_key: 'blank', url: 'http://test.com'
        expect(response.code).to eq '401'
      end
    end

    context 'with a valid api_key' do
      let(:json) { JSON.parse(response.body) }

      before do
        get :create, api_key: user.api_key, url: 'http://test.com'
      end

      it 'returns a JSON response' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns a short url' do
        expect(json.keys).to include 'shorturl'
        expect(json['shorturl']).to include assigns(:link).short_url
      end
    end

    context 'with an invalid url parameter' do
      let(:json) { JSON.parse(response.body) }

      before do
        get :create, api_key: user.api_key, url: 'illformed url'
      end

      it 'returns a JSON body with an error message' do
        expect(response.body).to include '{"errors":{"long_url":["is invalid"]}}'
      end
    end
  end

  describe '#show' do
    context 'using invalid api key' do
      it 'returns a 401' do
        get :show,  short_url: 'url_long', api_key: ' '
        expect(response.code).to eq '401'
      end
    end

    context 'using a valid api key and an invalid short url' do
      before do
        get :show, short_url: 'bad_url', api_key: user.api_key
      end

      it 'returns a json response containing an error' do
        expect(response.body).to include 'error'
      end
    end

    context 'using a valid api key and a valid short url' do
      let(:json) { JSON.parse(response.body) }

      before do
        get :create, api_key: user.api_key, url: 'http://example.com'
        short_url = JSON.parse(response.body)['shorturl'].split('/').last
        get :show, short_url: short_url, api_key: user.api_key
      end

      it 'returns a json response with the long url' do
        expect(json['long_url']).to include 'http://example.com'
      end
    end
  end
end
