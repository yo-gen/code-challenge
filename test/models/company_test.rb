require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save company without getmainstreet email" do
    company = Company.new(name: "Test Company", email: "withoutgetmainstreet@example.com")
    assert_not company.save
    assert company.errors.messages[:email].include?("must end with @getmainstreet.com")
  end

  test "should save company with blank email" do
    company = Company.new(name: "Test Company", email: "")
    assert company.save
  end

  test "should save company with valid email" do
    company = Company.new(name: "Test Company", email: "valid@getmainstreet.com")
    assert company.save
  end

  test "should update city and state when updated company zip code" do
    company = Company.new(name: "Test Company", email: "valid@getmainstreet.com", zip_code: "10001")
    assert company.save
    assert_equal company.city, "New York City"
    assert_equal company.state, "New York"
    #update zip code
    company.zip_code = "93001"
    assert company.save
    assert_equal company.city, "Ventura"
    assert_equal company.state, "California"
  end
end