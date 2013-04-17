class AlterEventTableAddEndDate < ActiveRecord::Migration
  def self.up
     add_column :events,:end_date,:date,:after => :date
  end

  def self.down                                                                 
    remove_column :events,:end_date                                     
  end
end
