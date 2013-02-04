class CreateYoutubeLinks < ActiveRecord::Migration
  def self.up
    create_table :youtube_links do |t|
      t.string :title
      t.text :link                                                      
      t.string :description                                                         
      t.string :creator                                                         
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :youtube_links
  end
end
