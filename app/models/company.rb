class Company < ApplicationRecord

	CUSTOM_EMAIL_ALLOWED= true

	has_paper_trail
  has_rich_text :description

  validate :email_check
  after_save_commit :set_city_and_state

  after_initialize :set_city_and_state

  private

  def email_check
    if (CUSTOM_EMAIL_ALLOWED) and (email.split("@").last != "getmainstreet.com")
 #TODO: We can i18n for message
      errors.add(:email, 'Sorry! Only getmainstreet.com users are allowed to register at this time')
    end unless email.blank?
  end

  def set_city_and_state
    zipcode_details = ZipCodes.identify(zip_code)
      unless zipcode_details.nil?
        self.city = zipcode_details[:city]
        self.state = zipcode_details[:state_code]
		end
  end

end
