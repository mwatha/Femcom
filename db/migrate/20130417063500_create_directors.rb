class CreateDirectors < ActiveRecord::Migration
  def self.up
    create_table :directors do |t|
      t.string :name
      t.string :title
      t.text :description
      t.string :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :directors
  end
end
