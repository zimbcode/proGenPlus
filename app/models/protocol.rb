class Protocol < ActiveRecord::Base
	has_many :topics
	accepts_nested_attributes_for :topics
end
