class Villa < ApplicationRecord
	scope :availabilities, -> { where(is_available: true) }
	scope :non_availabilities, -> { where(is_available: false) }
end
