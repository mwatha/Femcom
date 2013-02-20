class FemcomController < ApplicationController

  def events
    @events = Event.all
    @page_heading = 'Events'
  end

  def news
    @news = News.order("created_at DESC") 
    @page_heading = 'News'
  end

  def directors
    @page_heading = 'Directors'
  end

  def documents
    @documents = Document.order("created_at DESC")
    @page_heading = 'Documents (pdf)'
  end

  def download
    uri = params[:uri]
    send_file "#{Rails.root}/#{uri}", :type=>"application/zip" 
  end

  def about_us
    @page_heading = "About us"
  end

  def services
    @page_heading = "Services"
  end

  def national_chapters
    @page_heading = "National chapters"
  end

  def contact_us
    @page_heading = "Contact us"
  end

  def gallery
    @page_heading = "Gallery"
  end

  def get_pictures
    flickr = Flickr.new '4a1ffbf77f7785f3d6a3d95fbdc2d19b'
    render :partial => 'photos' , 
      :collection => flickr.photos(:tags => 'Malawi', :per_page => '50')
  end

  def album
    @album = Album.find(params[:id])
    pictures = @album.pictures
    @page_heading = @album.name

    @pictures = pictures.paginate(:page => 1)
  end

end
