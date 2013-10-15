require 'test_helper'

class OffersHelperTest < ActionView::TestCase

  should "return search param" do
    def params
      {search: {test: 123}}
    end
    assert_equal 123, search_param(:test)
  end

  should "return nil when no params found" do
    assert_nil search_param(:test2)
  end

  should "count items correctly" do
    assert_equal 3, item_num(2)
  end

  should "count items for 2nd page correctly" do
    def params
      {page: 2}
    end
    assert_equal Offer::PER_PAGE + 3, item_num(2)
  end

  context "sourche_checked?" do
    should "be checked by default" do
      assert_equal true, source_checked?(:test) 
    end
  end

end
