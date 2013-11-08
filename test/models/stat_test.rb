require 'test_helper'

class OfferTest < ActiveSupport::TestCase

  setup do
    @source_id = '0'
    Offer.stubs(:ru_sources).returns([@source_id.to_i])
  end

  context "daily stats" do

    should "calculate average count by week days" do
      create_offer(1.days.ago)
      create_offer(8.days.ago, 2)
      create_offer(2.days.ago, 6)
      result = {@source_id => [0,0,0,0,0,0,0]}
      result[@source_id][1.days.ago.strftime('%u').to_i - 1] = 2
      result[@source_id][2.days.ago.strftime('%u').to_i - 1] = 3

      assert_equal result, Stat.daily_stats
    end

    should "put sunday as a last day" do
      create_offer(Time.zone.now.sunday - 7.days, 2)
      result = {@source_id => [0,0,0,0,0,0,1]}

      assert_equal result, Stat.daily_stats
    end
    
    should "put monday as a first day" do
      create_offer(Time.zone.now.monday - 7.days, 2)
      result = {@source_id => [1,0,0,0,0,0,0]}

      assert_equal result, Stat.daily_stats
    end

  end

  context "last days stats" do
    should "get count of offers posted last days" do
      create_offer(1.days.ago)
      create_offer(2.days.ago, 2)
      create_offer(3.days.ago)
      create_offer(7.days.ago, 3)
      result = {@source_id => [3,0,0,0,1,2,1]}

      assert_equal result, Stat.last_days_stats
    end
  end

  def create_offer(time, amount = 1)
    amount.times{FactoryGirl.create(:offer, created_at: time, source: @source_id)}
  end

end
