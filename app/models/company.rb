class Company < ApplicationRecord
	has_paper_trail
  has_rich_text :description


end
