class Company < ApplicationRecord
  has_rich_text :description

  EMAIL_REGEX = /\A[a-zA-Z0-9_.+-]+@(?:(?:[a-zA-Z0-9-]+\.)?[a-zA-Z]+\.)?(getmainstreet)\.com\z/

  validates :email, allow_blank: true, format: { with: EMAIL_REGEX, message: I18n.t('company.invalid_email') }
end
