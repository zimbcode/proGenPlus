class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols do |t|
      t.string :creator
      t.date :dateCreated
      t.date :dateSent
      t.text :text

      t.timestamps
    end
  end
end
