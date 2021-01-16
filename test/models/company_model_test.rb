require "test_helper"

class CompanyModelTest < ActiveSupport::TestCase
	def setup
        @company = companies(:new_company)
    end

    test 'is company valid without email?' do
        @company.email = nil
        assert @company.valid?
    end

    test 'is company valid with invalid email?' do
        @company.email = "brown_painting@brown_painting.com"
        refute @company.valid?
      assert_not_nil @company.errors[:email]
    end

	test 'is company valid?' do
		assert @company.valid?
  end

end