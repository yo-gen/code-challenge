require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text @company.address
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "Create with Invalid Email" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "Invalid Email Company")
      fill_in("company_zip_code", with: "89899")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@gmail.com")
      assert_no_difference('Company.count') do
        click_button 'Create Company'
      end
    end
  end

  test "Create with Blank Email" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "Blank Email Company")
      fill_in("company_zip_code", with: "93003")
      click_button 'Create Company'
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "Blank Email Company", last_company.name
    assert_equal "93003", last_company.zip_code
  end

  test "Destroy" do
    visit company_path(@company)

    company_count = Company.count
    accept_alert do
      click_link('Delete')
    end

    assert_text "Company successfully destroyed."
    assert_equal company_count - 1, Company.count
  end

  test "Create with valid Zip code" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "Valid Zipcode Company")
      fill_in("company_zip_code", with: "30301")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "Atlanta", @company.city
    assert_equal "GA", @company.state
    assert_equal "Atlanta, GA", last_company.address
  end

  test "Create with invalid Zip code" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "Invalid Valid Zipcode Company")
      fill_in("company_zip_code", with: "ora-28173")
      assert_no_difference('Company.count') do
        click_button 'Create Company'
      end
    end
  end

  test "Create with Blank Zip code" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "Invalid Valid Zipcode Company")
      fill_in("company_zip_code", with: "")
      assert_no_difference('Company.count') do
        click_button 'Create Company'
      end
    end
  end

  test "Update with valid city and state if Zip code is changed" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "80201")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "80201", @company.zip_code
    assert_equal "Denver", @company.city
    assert_equal "CO", @company.state
    assert_equal "Denver, CO", @company.address
  end
end
