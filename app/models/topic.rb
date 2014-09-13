class Topic < ActiveRecord::Base
  belongs_to :protocol
  validates :headline, presence: true
  validates :text, presence: true
end
