class CreateTopicTags < ActiveRecord::Migration
  def change
    create_table :topic_tags do |t|

      t.timestamps
      t.belongs_to :topic
      t.belongs_to :tag
    end
  end
end
