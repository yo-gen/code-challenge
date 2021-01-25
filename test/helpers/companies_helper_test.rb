require "test_helper"

class CompaniesHelperTest < ActionView::TestCase
  test "should return the city and state for zipcode" do
    company = companies(:hometown_painting)
    assert_equal city_state(company), ""
    company.zip_code = "93001"
    company.save
    assert_equal city_state(company), "#{company.city}, #{company.state}"
  end
end