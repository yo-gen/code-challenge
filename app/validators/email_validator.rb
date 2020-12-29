class EmailValidator < ActiveModel::EachValidator
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  	EMAIL_DOMAIN = '@getmainstreet.com'.freeze

  	def validate(record)
  		if record.email.present?
	    	email = record.email.downcase
	   		record.errors.add :email, "email must end with #{EMAIL_DOMAIN}" unless email.end_with?(EMAIL_DOMAIN)
	    	record.errors.add :email, "email can only contains (0 to 9, a to z, ., _, -) characters" unless VALID_EMAIL_REGEX =~ email
		end
	end
end