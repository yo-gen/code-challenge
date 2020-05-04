require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'Company with getmainstreet.com email be valid' do
    assert companies(:hometown_painting).valid?
  end

  test 'Email must be from the getmainstreet.com domain' do
    refute companies(:brown_painting).valid?
    assert_includes companies(:brown_painting).errors.full_messages, 'Email must be from the getmainstreet.com domain'
  end

  test 'Blank email should be allowed' do
    assert companies(:marcus_painting).valid?
  end

  test 'Company with valid zipcode be valid' do
    assert companies(:hometown_painting).valid?
  end

  test 'Company with blank zipcode invalid' do
    refute companies(:armstrong_painting).valid?
    assert_includes companies(:armstrong_painting).errors.full_messages, "Zip code can't be blank"
  end

  test 'Company with invalid zipcode invalid' do
    refute companies(:armstrong_painting).valid?
    assert_includes companies(:armstrong_painting).errors.full_messages, 'Zip code is invalid'
  end

  test 'Company city and state with valid zip code' do
    hometown_painting = companies(:hometown_painting)
    hometown_painting.update(zip_code: '80201')

    assert_equal 'Denver', hometown_painting.city
    assert_equal 'CO', hometown_painting.state
  end
end