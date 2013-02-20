class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photo do |t|
      t.string :description                                                       
      t.string :uri
      t.integer :album_id
      t.string :creator                                                         
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :photo
  end
end
