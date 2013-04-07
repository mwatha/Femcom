class Photo < ActiveRecord::Base
  set_table_name :photo
  belongs_to :album, :class_name => 'Album',:foreign_key => 'album_id'

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
  
  def self.home_page(photo,upload)
    name =  upload['datafile'].original_filename                            
    file_extension = name[name.rindex(".") .. name.length].strip.chomp
    name = photo #"#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{file_extension}"
    directory = "#{Rails.root}/public/images/"                           
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }              
  end

  def self.news(upload)
    name =  upload['datafile'].original_filename                            
    file_extension = name[name.rindex(".") .. name.length].strip.chomp
    name = "#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{file_extension}"
    directory = "#{Rails.root}/public/images/news/"                           
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }              
    picture = NewsImages.new()
    picture.img = name
    picture.save
    return name
  end
  
  def self.chapter(chapter, upload)
    name =  upload['datafile'].original_filename                            
    file_extension = name[name.rindex(".") .. name.length].strip.chomp
    name = "#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{file_extension}"
    directory = "#{Rails.root}/public/images/NC/"                           
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }              
    chapter.flag = name
    chapter.save
  end
  
  protected

  def self.valid_size?(file_extension)
    not(file_extension.match(/pdf/i)).blank?
  end

end
