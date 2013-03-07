class Document < ActiveRecord::Base
  set_table_name :document

  def self.upload(title,upload)
    name =  upload['datafile'].original_filename                            
    file_extension = name[name.rindex(".") .. name.length].strip.chomp
    #return false unless self.pdf?(file_extension)
    name = "#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{file_extension}"
    directory = "#{Rails.root}/pdf"                           
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }              
    document = self.new()
    document.title = title
    document.uri = 'pdf/' + name
    document.save
  end

  protected

  def self.pdf?(file_extension)
    not(file_extension.match(/pdf/i)).blank?
  end

end
