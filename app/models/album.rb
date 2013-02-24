class Album < ActiveRecord::Base
  set_table_name :albums

  has_many :pictures, :class_name => 'Photo',:foreign_key => 'album_id'

end
