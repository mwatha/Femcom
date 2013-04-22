class AlterCurrentFocusAndActivitiesTableAddDescription < ActiveRecord::Migration
  def self.up
     add_column :current_focus_and_activities,:description,:text,:after => :title
  end

  def self.down                                                                 
    remove_column :current_focus_and_activities,:description                                   
  end
end
