class TwitterJob < ActiveJob::Base

  def perform(user_id, tweet_text)
    user = User.find(user_id)
    user.tweet(tweet_text)
  end
end
