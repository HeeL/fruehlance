require 'test_helper'

class OfferTest < ActiveSupport::TestCase

  context 'search' do
    
    setup do
      @rails_item = FactoryGirl.create(:offer, title: 'Ruby on Rails', desc: 'something about the great framework');
      @php_item = FactoryGirl.create(:offer, title: 'Zend Framework', desc: 'here is a text that includes php');
    end

    should "search by title and description" do
      rails_results = Offer.search({query: 'rails'}, 1)
      assert_equal 1, rails_results.count
      assert_equal @rails_item, rails_results.first

      php_results = Offer.search({query: 'php'}, 1)
      assert_equal 1, php_results.count
      assert_equal @php_item, php_results.first
    end

    should "ignore words less then 3 symbols" do
      results = Offer.search({query: 'the php'}, 1)
      assert_equal 1, results.count
      assert_equal @php_item, results.first
    end

    should "ignore 'the'" do
      results = Offer.search({query: 'is ruby'}, 1)
      assert_equal 1, results.count
      assert_equal @rails_item, results.first
    end

    should "search for c#" do
      FactoryGirl.create(:offer, title: 'here is the C#');
      assert_equal 1, Offer.search({query: 'c#'}, 1).count
    end
  end

  context "validations" do
    should "validate description" do
      offer = Offer.new
      offer.valid?
      assert_equal 2, offer.errors[:desc].count
      offer.desc = 'Short one'
      offer.valid?
      assert_equal 1, offer.errors[:desc].count
      offer.desc = 'A valid long description'
      offer.valid?
      assert_equal 0, offer.errors[:desc].count
    end

    should "validate title" do
      offer = Offer.new
      offer.valid?
      assert_equal 2, offer.errors[:title].count
      offer.title = 'xy'
      offer.valid?
      assert_equal 1, offer.errors[:title].count
      offer.title = 'The Title'
      offer.valid?
      assert_equal 0, offer.errors[:title].count
    end

    should "validate presence of fields" do
      offer = Offer.new
      offer.valid?
      [:title, :desc, :ext_id, :posted_at, :source, :offer_url].each do |field|
        assert "can't be blank", offer.errors[field].first
      end
    end
  end

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
