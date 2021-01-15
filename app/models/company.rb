class Company < ApplicationRecord
  has_rich_text :description

  validates :email, format: { with: /@getmainstreet.com/,
                message: "validation failed. Your email address must end with suffix `@getmainstreet.com`" }
end
