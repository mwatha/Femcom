class UserController < ApplicationController
  after_filter :wrap_ajax_response, :only => [:upload]

  def login
    if request.post?
      user = User.find_by_username params[:username]                                      
      if user and user.password_matches?(params[:password])                       
        session[:user_id] = user.id
        redirect_to "/user/admin" and return
      else                                                                        
        flash[:error] = 'That username and/or password was not valid.'            
      end   
    else
      reset_session
    end
    @page_heading = 'Login'
  end

  def logout
    reset_session
    redirect_to "/" and return
  end

  def admin
    @page_heading = 'Administartion'
    render :layout => false
  end

  def blank
    render :layout => false
  end

  def create_news
    if request.post?
      News.create(:title => params[:title],:post => params[:post])
      flash[:notice] = 'Successfully posted.'            
    end
    render :layout => false
  end

  def upload_pdf
    if request.post?
      Document.upload(params[:title],params[:upload],params[:category])
      flash[:notice] = 'File was successfully uploaded.'
    end
    @categories = DocumentCategory.order("created_at DESC")
    render :layout => false
  end

  def create_video_link
    if request.post?
      YoutubeLinks.create(:title => params[:title],:link => params[:uri],
        :description => params[:description])
      flash[:notice] = 'Video successfully linked.'
    end
    render :layout => false
  end

  def create_events
    if request.post?
      Event.create(:title => params[:title],:venue => params[:venue],
        :description => params[:post],:date => params[:start_date],:end_date => params[:end_date])
      flash[:notice] = 'Event successfully created.'
    end
    render :layout => false
  end

  def number_of_events
    render :text => Event.where(:'date' => params[:date]).count and return
  end

  def upload_pictures
    if request.post?
      album = Album.find(params[:album_id])
      Photo.upload(album,params[:picture_description],params[:upload])
      flash[:notice] = 'Photo successfully uploaded.'
    end
    @albums = Album.order('name ASC,created_at DESC')
    render :layout => false
  end

  def upload_new_pictures
    if request.post?
      album = Album.new()
      album.name = params[:album]
      album.description = params[:album_description]
      album.creator = User.current_user
      album.save
      flash[:notice] = 'Album successfully created.'
      #Photo.upload(album,params[:picture_description],params[:upload])
    end
    render :layout => false
  end

  def edit_news
    @news = News.order("created_at DESC")
    render :layout => false
  end

  def news_edit
    @news = News.find(params[:id])
    render :layout => false
  end

  def delete_post
    case params[:type]
      when 'national_chapter'
        chapter = NationalChapters.find(params[:id])
       `rm #{Rails.root}/public/images/NC/#{chapter.flag}`
        NationalChapters.delete(chapter.id)
        flash[:notice] = 'Successfully delete.' 
        redirect_to :action => :national_chapters_list
        return
      when 'delete_director'
        director = Directors.find(params[:id])
       `rm #{Rails.root}/public/images/directors/#{director.picture}`
        Directors.delete(director.id)
        flash[:notice] = 'Successfully delete.' 
        redirect_to :action => :directors
        return
      when 'delete_partner'
        partner = Partners.find(params[:id])
       `rm #{Rails.root}/public/images/partners/#{partner.logo}`
        Partners.delete(partner.id)
        flash[:notice] = 'Successfully delete.' 
        redirect_to :action => :partners
        return
      when 'album'
        album = Album.find(params[:id])
        (album.pictures || []).each do |picture|
          `rm #{Rails.root}/public/images/pictures/#{picture.uri}`
          Photo.delete(picture.id)
        end
        Album.delete(params[:id])
        redirect_to :controller => :femcom, :action => :gallery
        return
      when 'video'
        YoutubeLinks.delete(params[:id])
        redirect_to :controller => :media , :action => :videos
        return
      when 'delete_video'
        YoutubeLinks.delete(params[:id])
        redirect_to :action => :youtube_video_list
        return
      when 'delete_news_post'
        News.delete(params[:id])
      when 'documents'
        (params[:ids].split(',') || []).each do |id|
          Document.delete(id)
        end
      when 'delete_event'
        Event.delete(params[:id])
        redirect_to :action => :event_edit and return
      when 'update_news_post'
        post = News.find(params[:id])
        post.title = params[:title]
        post.post = params[:post]
        posted_datetime = params[:created_at].to_date.strftime("%Y-%m-%d #{Time.now().strftime('%H:%M:%S')}").to_time
        post.created_at = posted_datetime
        post.save
        redirect_to :action => :edit_news and return
      when 'photo'
        photo = Photo.find(params[:id])
        `rm #{Rails.root}/public/images/pictures/#{photo.uri}`
        Photo.delete(params[:id])
        if photo.album.pictures.blank?
          Album.delete(photo.album.id)
          redirect_to :controller => :femcom, :action => :gallery and return
        else
          redirect_to :controller => :femcom, :action => :album,:id => photo.album.id and return
        end
      when 'delete_home_page_content'
        HomeContentPost.delete(params[:id])
        redirect_to '/user/home_page' and return
      when 'delete_services_post'
        Services.delete(params[:id])
        redirect_to '/user/services_list' and return
      when 'delete_document_category'
        DocumentCategory.delete(params[:id])
        redirect_to '/user/document_category_list' and return
    end
    redirect_to :action => :blank and return
  end

  def edit_files
    @documents = Document.order('created_at DESC')
    render :layout => false
  end

  def event_edit
    @events = Event.order('created_at DESC')
    render :layout => false
  end
  
  def edit_password
    if request.post?
      if params[:new_password] == params[:confirm_password]
         User.find(:last).update_attributes(:password_hash => params[:new_password])
         flash[:notice] = 'Password was successfully updated.' 
         redirect_to :action => :blank and return
      end
    end
    render :layout => false
  end

  def home_page
    @contents = HomeContentPost.order("created_at DESC")
    render :layout => false
  end

  def create_home_page_content
    if request.post?
      HomeContentPost.create(:title => params[:title],:content => params[:post])
      flash[:notice] = 'Successfully posted.'            
    end
    render :layout => false
  end

  def edit_home_page_content
    if request.post?
      content = HomeContentPost.find(params[:content_id])
      content.title = params[:title]
      content.content = params[:post]
      content.save
      redirect_to :action => :home_page and return
    else
      @content = HomeContentPost.find(params[:id])
    end
    render :layout => false
  end

  def change_home_page_photos
    if request.post?
      Photo.home_page(params[:photo],params[:upload])
      flash[:notice] = 'Successfully posted new picture'            
    end
    @photos = ["1.jpg","2.jpg","3.jpg","4.png","5.jpg"]
    render :layout => false
  end

  def current_focus_and_activities
    if request.post?
      CurrentFocusAndActivities.create(:title => params[:title],:uri => params[:uri],
        :voided => 0,:description => params[:description])
      flash[:notice] = 'Successfully created activity'            
    end
    render :layout => false
  end

  def current_focus_and_activities_list
    unless params[:id].blank?
      CurrentFocusAndActivities.delete(params[:id])
    end
    @activities = CurrentFocusAndActivities.order('created_at DESC')
    render :layout => false
  end

  def ajax_upload
    flash.now[:notice] = "Works!"
    render :layout => false
  end

  def upload
    @img = Photo.news(params[:upload])
    render :layout => false
  end

  def services_create
    if request.post?
      Services.create(:title => params[:title],:post => params[:post])
      flash[:notice] = 'Successfully posted.'            
    end
    render :layout => false
  end

  def services_list
    @list = Services.order("created_at DESC")
    render :layout => false
  end

  def services_edit
    if request.post?
      content = Services.find(params[:id])
      content.title = params[:title]
      content.post = params[:post]
      content.save
      flash[:notice] = 'Successfully updated.'            
      redirect_to '/user/services_list' and return
      return
    else
      @service = Services.find(params[:id])
    end
    render :layout => false
  end

  def upload_post_images
    @img = Photo.news(params[:upload])
    render :layout => false
  end

  def document_category_list
    @categories = DocumentCategory.order("created_at DESC")
    render :layout => false
  end

  def create_document_category
    if request.post?
      DocumentCategory.create(:name => params[:name],:description => params[:post])
      flash[:notice] = 'Successfully created.'            
      redirect_to '/user/document_category_list' and return
    end
    render :layout => false
  end

  def edit_event
    @event = Event.find(params[:id])
    if request.post?
      @event.title = params[:title]
      @event.venue = params[:venue]
      @event.description = params[:post]
      @event.date = params[:start_date]
      @event.end_date = params[:end_date]
      @event.save
      flash[:notice] = 'Successfully updated.'            
      redirect_to '/user/event_edit' and return
    end
    render :layout => false
  end

  def national_chapters_list
    @chapters = NationalChapters.order("country")
    render :layout => false
  end

  def create_chapters
    if request.post?
      NationalChapters.create(:country => params[:country],:member => params[:member],
        :title => params[:title], :address => params[:address],
        :phone => params[:phone], :email => params[:email])
      flash[:notice] = 'Successfully creates.'            
      redirect_to '/user/national_chapters_list' and return
    end
    render :layout => false
  end

  def national_chapters_edit
    @chapter = NationalChapters.find(params[:id])
    if request.post?
      @chapter.country = params[:country]
      @chapter.member = params[:member]
      @chapter.title = params[:title]
      @chapter.address = params[:address]
      @chapter.phone = params[:phone]
      @chapter.email = params[:email]
      @chapter.save
      flash[:notice] = 'Successfully updated.'            
      redirect_to '/user/national_chapters_list' and return
    end
    render :layout => false
  end

  def add_national_chapters_flag
    @chapters = NationalChapters.order("country")
    if request.post?
      chapter = NationalChapters.find(params[:country_id])
      Photo.chapter(chapter,params[:upload])
      flash[:notice] = 'Photo successfully uploaded.'
    end
    render :layout => false
  end

  def album_list
    @albums = Album.order("created_at DESC")
    render :layout => false
  end

  def album_edit
    @album = Album.find(params[:id])
    if request.post?
      @album.name = params[:album]
      @album.description = params[:album_description]
      @album.save
      flash[:notice] = 'Album successfully updated.'
      redirect_to '/user/album_list' and return
    end
    render :layout => false
  end

  def partners
    @partners = Partners.order('name ASC')
    render :layout => false
  end

  def directors
    @directors = Directors.order("created_at DESC")
    render :layout => false
  end

  def new_director
    if request.post?
      director = Directors.new()
      director.name = params[:name]
      director.title = params[:title]
      director.description = params[:description]
      director.save
      flash[:notice] = 'Successfully added new director.'
      redirect_to '/user/directors' and return
    end
    render :layout => false
  end
  
  def director_edit
    @director = Directors.find(params[:id])
    if request.post?
      @director.name = params[:name]
      @director.title = params[:title]
      @director.description = params[:description]
      @director.save
      flash[:notice] = "Successfully updated director's details."
      redirect_to '/user/directors' and return
    end
    render :layout => false
  end 

  def add_director_picture
    if request.post?
      director = Directors.find(params[:id])
      Photo.director(director,params[:upload])
      flash[:notice] = 'Successfully added new director picture.'
      redirect_to '/user/directors' and return
    else
      @directors = Directors.order('name ASC')
    end
    render :layout => false
  end

  def new_partner
    if request.post?
      partner = Partners.new()
      partner.name = params[:name]
      partner.link = params[:link]
      partner.description = params[:description]
      partner.save
      flash[:notice] = 'Successfully added new partner.'
      redirect_to '/user/partners' and return
    end
    render :layout => false
  end
  
  def partner_edit
    @partner = Partners.find(params[:id])
    if request.post?
      @partner.name = params[:name]
      @partner.link = params[:link]
      @partner.description = params[:description]
      @partner.save
      flash[:notice] = "Successfully updated partner's details."
      redirect_to '/user/partners' and return
    end
    render :layout => false
  end

  def add_partner_logo
    if request.post?
      partner = Partners.find(params[:id])
      Photo.partner(partner,params[:upload])
      flash[:notice] = 'Successfully added new partner logo.'
      redirect_to '/user/partners' and return
    else
      @partners = Partners.order('name ASC')
    end
    render :layout => false
  end

  def youtube_video_list
    @videos = YoutubeLinks.order("created_at DESC")
    render :layout => false
  end

  def video_edit
    @video = YoutubeLinks.find(params[:id])
    if request.post?
      @video.title = params[:title]
      @video.link = params[:link]
      @video.description = params[:description]
      @video.save
      flash[:notice] = "Successfully updated."
      redirect_to '/user/youtube_video_list' and return
    end
    render :layout => false
  end

  def category_edit
    @category = DocumentCategory.find(params[:id])
    if request.post?
      @category.name = params[:name]
      @category.description = params[:description]
      @category.save
      flash[:notice] = "Successfully updated."
      redirect_to '/user/document_category_list' and return
    end
    render :layout => false
  end

  def links_other_websites_edit
    @link = CurrentFocusAndActivities.find(params[:id])
    if request.post?
      @link.title = params[:title]
      @link.uri = params[:uri]
      @link.description = params[:description]
      @link.save
      flash[:notice] = "Successfully updated."
      redirect_to '/user/current_focus_and_activities_list' and return
    end
    render :layout => false
  end

  private

  def wrap_ajax_response
    response.content_type = nil
    response.body = "<img src='/images/news/#{@img}' width=558 height=300 />"
  end

end
