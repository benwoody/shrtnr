FactoryGirl.define do
  factory :link do
    short_url 'abc123'
    long_url 'http://google.com'
    clicks 0
  end
end
