class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :document do |t|
      t.string :title                                                       
      t.string :uri
      t.string :creator                                                         
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :document
  end
end
