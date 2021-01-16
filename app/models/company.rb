class Company < ApplicationRecord
  has_rich_text :description
  validates :email, presence: true, if: :valid_email? 

  def valid_email?
  	email.split("@").last == 'getmainstreet.com'
  end
end
