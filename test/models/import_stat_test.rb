require 'test_helper'

class ImportStatTest < ActiveSupport::TestCase

  context "#delete_old!" do
    setup do
      FactoryGirl.create(:import_stat, created_at: 1.month.ago)
      @not_old_import_stat = FactoryGirl.create(:import_stat, created_at: 26.days.ago)
      FactoryGirl.create(:import_stat, created_at: 1.year.ago)
    end

    should "delete old import stats" do
      ImportStat.delete_old!
      assert_equal 1, ImportStat.count
      assert_equal ImportStat.first.id, @not_old_import_stat.id
    end
  end

end
