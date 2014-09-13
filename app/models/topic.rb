class Topic < ActiveRecord::Base
  belongs_to :protocol
  validates :headline, presence: true
  validates :text, presence: true
  has_many :topic_tags
  has_many :tags, through: :topic_tags
end
