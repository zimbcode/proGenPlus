class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :headline
      t.text :text
      t.references :protocol, index: true

      t.timestamps
    end
  end
end
