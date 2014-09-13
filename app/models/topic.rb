class Topic < ActiveRecord::Base
  belongs_to :protocol
  validates :headline, presence: true
  validates :text, presence: true
  belongs_to :topic_tag
  has_many :tags, through: :topic_tag
end
