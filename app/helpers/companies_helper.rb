module CompaniesHelper
  def city_state(company)
    return "" unless company.city.present? && company.state.present?
    "#{company.city}, #{company.state}"
  end
end