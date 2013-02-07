class FemcomController < ApplicationController
  def events
    @events = Event.all
    render :layout => false
  end

  def news
    @news = News.all
    render :layout => false
  end

  def directors
    @picture = params[:id]
    render :layout => false
  end

  def documents
    @documents = Document.all
    render :layout => false
  end

  def download
    uri = params[:uri]
    send_file "#{Rails.root}/#{uri}", :type=>"application/zip" 
  end

end
