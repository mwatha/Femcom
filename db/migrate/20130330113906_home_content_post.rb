class HomeContentPost < ActiveRecord::Migration
  def self.up
    create_table :home_content_post do |t|
      t.string :title                                                       
      t.text :content                                                         
      t.string :creator                                                         
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :home_content_post
  end

end
