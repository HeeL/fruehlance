require 'test_helper'

class OfferTest < ActiveSupport::TestCase

  context "#delete_old!" do
    setup do
      FactoryGirl.create(:offer, created_at: 1.week.ago)
      @not_old_offer = FactoryGirl.create(:offer, created_at: 6.days.ago)
      FactoryGirl.create(:offer, created_at: 1.year.ago)
    end

    should "delete old offers" do
      Offer.delete_old!
      assert_equal 1, Offer.count
      assert_equal Offer.first.id, @not_old_offer.id
    end
  end

end
