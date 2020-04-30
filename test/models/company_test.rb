require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'invalid with incorrect domain in emails' do
    company = Company.new(
      name:  'New Company',
      email: 'new_company@test.com',
      phone: '555-808-8888'
    )
    refute company.valid?
    assert_not_nil company.errors[:email]
  end
end
