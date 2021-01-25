class Company < ApplicationRecord
  has_rich_text :description
  before_save :update_city_state, if: :will_save_change_to_zip_code?

  validate :email_domain_is_getmainstreet, if: -> { email.present? }


  private

  def email_domain_is_getmainstreet
    unless email.end_with? '@getmainstreet.com'
      errors.add :email, I18n.t('errors.main_street_domain_email_error')
    end
  end

  def update_city_state
    return if zip_code.blank?
    zip_h = ZipCodes.identify(zip_code)
    return if zip_h.blank?
    self.city = zip_h[:city]
    self.state = zip_h[:state_name]
  end
end
