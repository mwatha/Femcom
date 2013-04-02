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
  end

  def blank
    render :layout => false
  end

  def create_news
    if request.post?
      News.create(:title => params[:title],:post => params[:content])
      flash[:notice] = 'Successfully posted.'            
      redirect_to :action => :blank and return
    end
    render :layout => false
  end

  def upload_pdf
    if request.post?
      Document.upload(params[:title],params[:upload])
      flash[:notice] = 'File was successfully uploaded.'
    end
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
        :description => params[:description],:date => params[:date])
      flash[:notice] = 'Event successfully created.'
    end
    @next_appointment_date = Date.today
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
      when 'delete_news_post'
        News.delete(params[:id])
      when 'documents'
        (params[:ids].split(',') || []).each do |id|
          Document.delete(id)
        end
      when 'events'
        (params[:ids].split(',') || []).each do |id|
          Event.delete(id)
        end
      when 'update_news_post'
        post = News.find(params[:id])
        post.title = params[:title]
        post.post = params[:content]
        post.save
      when 'photo'
        photo = Photo.find(params[:id])
        `rm #{Rails.root}/public/images/pictures/#{photo.uri}`
        Photo.delete(params[:id])
        if photo.album.blank?
          redirect_to :controller => :femcom, :action => :gallery and return
        else
          redirect_to :controller => :femcom, :action => :album,:id => photo.album.id and return
        end
      when 'delete_home_page_content'
        HomeContentPost.delete(params[:id])
        redirect_to '/user/admin' and return
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
      HomeContentPost.create(:title => params[:title],:content => params[:content])
      flash[:notice] = 'Successfully posted.'            
    end
    render :layout => false
  end

  def edit_home_page_content
    unless request.post?
      @content = HomeContentPost.find(params[:id])
    else
      content = HomeContentPost.find(params[:content_id])
      content.title = params[:title]
      content.content = params[:content]
      content.save
      redirect_to :action => :home_page and return
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
      CurrentFocusAndActivities.create(:title => params[:title],:uri => params[:uri],:voided => 0)
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

  private

  def wrap_ajax_response
    response.content_type = nil
    response.body = "<img src='/images/news/#{@img}' style='width: 99%; height: 300px;' />"
  end

end
