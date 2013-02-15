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
end
