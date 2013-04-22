class FemcomController < ApplicationController

  def events
    @events = Event.order("created_at DESC")
    @page_heading = 'Events'
  end

  def news
    @news = []
    news = News.order("created_at DESC")
    (news || []).each do |post|
      if months_gone(post.created_at) > 0
        post.voided = 1
        post.save
      end
      @news << post
    end
    @page_heading = 'News'
  end

  def archives
    @news = News.order("created_at DESC").where(:'voided' => 1) 
    @page_heading = 'Archives'
  end

  def link
    @link = CurrentFocusAndActivities.find(params[:id])
    @page_heading = 'Link'
  end

  def directors
    @directors = Directors.order('name DESC')
    @page_heading = 'Directors'
  end

  def documents
    documents = Document.order("created_at DESC")
    @categories = []
    (documents || []).each do |doc|
      next if doc.document_category.blank?
      @categories << doc.document_category 
    end
    
    @categories = @categories.uniq rescue []
    @page_heading = 'Resources'
  end

  def download
    uri = params[:uri]
    send_file "#{Rails.root}/#{uri}", :type=>"application/zip" 
  end

  def about_us
    @page_heading = "About us"
  end

  def services
    @contents = Services.order("created_at DESC")
    @page_heading = "Services"
  end

  def national_chapters
    @chapters = NationalChapters.order("country ASC")
    @page_heading = "National chapters"
  end

  def contact_us
    @page_heading = "Contact us"
  end

  def gallery
    @albums = Album.paginate(:per_page => 9,:page => params[:page]).order("created_at DESC")
    @page_heading = "Gallery"
  end

  def album
    @album = Album.find(params[:id])
    @pictures = @album.pictures
    @page_heading = 'Album'
    @album_description = @album.name 
    @album_description += ' - ' + @album.description unless @album.description.blank?
  end

  def event
    @event = Event.find(params[:id])
    @page_heading = @event.title
  end

  def documents_by_category
    @category = DocumentCategory.find(params[:id])
    @documents = @category.documents
  end

  def partners
    @partners = Partners.order("name ASC")
  end

  protected

  def months_gone(date_created , reference_date = Time.now)                                  
    ((reference_date.to_time - date_created.to_time)/1.month).floor           
  end

end
