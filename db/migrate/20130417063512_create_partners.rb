class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.string :name
      t.text :description
      t.text :link
      t.string :logo

      t.timestamps
    end
  end

  def self.down
    drop_table :partners
  end
end
