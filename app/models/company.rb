class Company < ApplicationRecord
  has_rich_text :description

  validate :email_domain
  after_save_commit :update_city_state, if: :saved_change_to_zip_code?

  private

  def email_domain
    if email.split("@").last != "getmainstreet.com"
      errors.add(:email, 'Sorry! Only company domain emails can be used for creating emails.')
    end unless email.blank?
  end

  def update_city_state
    state_hash = ZipCodes.identify(self.zip_code)
    self.update({city: state_hash[:city], state: state_hash[:state_code]}) unless state_hash.nil?
  end

end
