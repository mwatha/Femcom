class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username                                                       
      t.text :password_hash                                                         
      t.string :people_id                                                     
      t.string :creator                                                         
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
