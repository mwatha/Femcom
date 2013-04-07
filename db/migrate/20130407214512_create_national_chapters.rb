class CreateNationalChapters < ActiveRecord::Migration
  def self.up
    create_table :national_chapters do |t|
      t.string :country
      t.string :flag
      t.string :member
      t.string :title
      t.text :address
      t.string :phone
      t.text :email

      t.timestamps
    end
  end

  def self.down
    drop_table :national_chapters
  end
end
