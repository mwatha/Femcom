class CreateCurrentFocusAndActivities < ActiveRecord::Migration
  def self.up
    create_table :current_focus_and_activities do |t|
      t.string :title
      t.text :uri
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :current_focus_and_activities
  end
end
