class UserController < ApplicationController
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
    end
    render :layout => false
  end

  def upload_pdf
    if request.post?
      Document.upload(params[:title],params[:upload])
    end
    render :layout => false
  end

  def create_video_link
    if request.post?
      YoutubeLinks.create(:title => params[:title],:link => params[:uri],
        :description => params[:description])
    end
    render :layout => false
  end

  def create_events
    if request.post?
      Event.create(:title => params[:title],:venue => params[:venue],
        :description => params[:description],:date => params[:date])
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
      #Photo.upload(album,params[:picture_description],params[:upload])
    end
    render :layout => false
  end

  def edit_news
    render :layout => false
  end

  def news_edit
    @news = News.find(params[:id])
    render :layout => false
  end

  def delete_post
    case params[:type]
      when 'delete_news_post'
        News.delete(params[:id])
      when 'documents'
        (params[:ids].split(',') || []).each do |id|
          Document.delete(id)
        end
      when 'update_news_post'
        post = News.find(params[:id])
        post.title = params[:title]
        post.post = params[:content]
        post.save
    end
    redirect_to :action => :blank
  end

  def edit_files
    @documents = Document.order('created_at DESC')
    render :layout => false
  end

end
