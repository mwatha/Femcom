class CreateNewsImages < ActiveRecord::Migration
  def self.up
    create_table :news_images do |t|
      t.string :img                                                   

      t.timestamps
    end
  end

  def self.down
    drop_table :news_images
  end
end
