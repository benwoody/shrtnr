require 'spec_helper'

describe TwitterJob, type: :job do
  let(:user) { create(:user) }
  let(:tweet) { "Hello, World!" }

  describe "sends a tweet" do
    it "requests to Twitter" do
      stub_tweet
      TwitterJob.perform_now(user.id, tweet)
      expect(WebMock).to have_requested(:post, /api.twitter.com/)
    end
  end
end
