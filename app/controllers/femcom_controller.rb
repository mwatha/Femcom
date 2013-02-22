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
    @albums = Album.paginate(:per_page => 10,:page => params[:page]).order("created_at DESC")
    @page_heading = "Gallery"
  end

  def album
    @album = Album.find(params[:id])
    @pictures = @album.pictures
    @page_heading = 'Album'
    @album_description = @album.name 
    @album_description += ' - ' + @album.description unless @album.description.blank?
  end

end
