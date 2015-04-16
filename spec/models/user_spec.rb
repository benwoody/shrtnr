require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  let(:new_user) { create(:user) }
  let(:auth) { OmniAuth.config.add_mock(:twitter, { uid: '12345',
                                                    info: { nickname: 'test_user' }
                                                  }) }
  it "has a valid factory" do
    expect(user).to be_valid
  end

  context ".from_twitter" do
    it "create a new user from oauth" do
      expect { User.from_twitter(auth) }.to change(User, :count).by(1)
    end

    it "sets the users name" do
      expect(User.from_twitter(auth).name).to eq 'test_user'
    end
  end

  context ".link_twitter" do
    it "add twitter id to user uid" do
      user.link_twitter(auth)
      expect(user.uid).to eq('12345')
    end
  end

  context ".twitter_linked?" do
    it "reports true if uid is present" do
      user.link_twitter(auth)
      expect(user.twitter_linked?).to be_truthy
    end

    it "reports false if uid is absent" do
      expect(new_user.twitter_linked?).to be_falsey
    end
  end
end
