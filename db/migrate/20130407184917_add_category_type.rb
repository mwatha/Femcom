class AddCategoryType < ActiveRecord::Migration
  def self.up
     add_column :document,:category,:integer,:null => false,:default => 0,:after => :id
  end

  def self.down
    remove_column :document,:category
  end
end
