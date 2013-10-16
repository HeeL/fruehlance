FactoryGirl.define do
  factory :offer do
    title 'Looking for a Ruby Developer'
    desc 'We are seriously looking for a one great dev, please be the one'
    posted_at Date.yesterday
    source 1
    sequence(:ext_id)
    sequence(:offer_url){|i| "http://example.com/offer/#{i}"}
  end
end