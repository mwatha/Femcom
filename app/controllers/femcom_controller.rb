class FemcomController < ApplicationController

  def events
    @events = Event.all
  end

  def news
    @news = News.order("created_at DESC") 
  end

  def directors
  end

  def documents
    @documents = Document.order("created_at DESC")
  end

  def download
    uri = params[:uri]
    send_file "#{Rails.root}/#{uri}", :type=>"application/zip" 
  end

  def about_us
    @page_heading = "About us"
  end

end
