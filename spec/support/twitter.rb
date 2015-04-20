def stub_tweet
  ret = File.open("#{Rails.root}/spec/support/tweet_return.json")
  stub_request(:post, /api.twitter.com/).
    to_return(status:200, body: ret)
end
# stub_request is from webmock. 
# The stub request says that if a post is made to api.twitter.com, 
# return instead a body pulled from the given file and a status of 200
