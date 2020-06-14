class Company < ApplicationRecord

	CUSTOM_EMAIL_ALLOWED= true

	has_paper_trail
  has_rich_text :description

  validate :email_check

  private

  def email_check
    if (CUSTOM_EMAIL_ALLOWED) and (email.split("@").last != "getmainstreet.com")
      errors.add(:email, 'Sorry! Only getmainstreet.com users are allowed to register at this time')
    end unless email.blank?
  end

end
