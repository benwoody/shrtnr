require 'spec_helper'

describe Api::V1::UsersController, type: :controller do

  let (:link1) { create(:link) }
  let (:link2) { create(:link) }
  let(:user) { create(:user) }

  describe "#show" do
    context  "with invalid api_key" do
      it "returns a 401" do
        get :show, id: user.id, api_key: 'blank'
        expect(response.code).to eq '401'
      end
    end

    context "with a valid api_key" do
      render_views

      let(:json) { JSON.parse(response.body) }

      before do
        # add links to user first
        user.links << link1
        user.links << link2
        user.save!
        get :show, id: user.id, api_key: user.api_key
      end

      it "returns a JSON response" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns the correct JSON" do
        user_json = json['user']
        link1_json = user_json['links'][0]
        link2_json = user_json['links'][1]

        expect(user_json['name']).to eq user.name
        expect(user_json['email']).to eq user.email
        verify_link(link1_json, link1)
        verify_link(link2_json, link2)
      end

      def verify_link(json, link)
        expect(json['short_url']).to include link.short_url
        expect(json['long_url']).to eq link.long_url
        expect(json['clicks']).to eq link.clicks
      end

      it "returns a JSON with the correct keys" do
        expect(json.keys).to contain_exactly('user')
        expect(json['user'].keys).to contain_exactly('name', 'email', 'links')
        json['user']['links'].each do |link_json|
          expect(link_json.keys).to contain_exactly('short_url', 'long_url', 'clicks')
        end
      end
    end
  end
end
