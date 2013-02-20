class Photo < ActiveRecord::Base
  set_table_name :photo

  def self.upload(album,description,upload)
    name =  upload['datafile'].original_filename                            
    file_extension = name[name.rindex(".") .. name.length].strip.chomp
    name = "#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{file_extension}"
    directory = "#{Rails.root}/public/images/pictures/"                           
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }              
    picture = self.new()
    picture.description = description
    picture.uri = name
    picture.album_id = album.id
    picture.save
  end

  protected

  def self.valid_size?(file_extension)
    not(file_extension.match(/pdf/i)).blank?
  end

end
