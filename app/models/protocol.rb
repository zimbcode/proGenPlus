class Protocol < ActiveRecord::Base
	has_many :topics
	accepts_nested_attributes_for :topics
	has_many :tags, through: :topics
	
	accepts_nested_attributes_for :topics, reject_if: Proc.new{|attributes| attributes['headline'].blank? and attributes['text'].blank?}
end
