class Company < ApplicationRecord
	include ActiveModel::Validations
	DEFAULT_BRAND_COLOR = '#61a946'.freeze

  has_rich_text :description
  validates_with EmailValidator, :attributes=>[:email]
  before_save :set_city_and_state_with_zip_code, if: ->() { self.zip_code.present? }
  after_initialize :set_city_and_state_with_zip_code, if: ->() { self.zip_code.present? }
  after_initialize :set_default_color
  
 	private

 	def set_default_color
    self.brand_color ||= DEFAULT_BRAND_COLOR
  end

 	def set_city_and_state_with_zip_code
 		zip = ZipCodes.identify(self.zip_code)
 		self.city = zip[:city]
 		self.state = zip[:state_code]
 	end
end
