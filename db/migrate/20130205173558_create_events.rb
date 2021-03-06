class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title                                                       
      t.string :venue
      t.date :date
      t.text :description
      t.string :creator                                                         
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
