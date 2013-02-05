class UserController < ApplicationController
  def login
    if request.post?
      user = User.find_by_username params[:username]                                      
      if user and user.password_matches?(params[:password])                       
        session[:user_id] = user.id
        redirect_to "/home/index" and return
      else                                                                        
        flash[:error] = 'That username and/or password was not valid.'            
      end   
    else
      reset_session
    end
    render :layout => false
  end

  def logout
    reset_session
    redirect_to "/home/index" and return
  end

  def admin
    render :layout => false
  end

  def blank
    render :layout => false
  end

  def create_news
    if request.post?
      News.create(:title => params[:title],:post => params[:body])
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
      Document.upload(params[:title],params[:upload])
    end
    @next_appointment_date = Date.today
    render :layout => false
  end

  def number_of_events
    render :text => Event.where("DATE(created_at)=?",
      Date.today).count and return
  end
end
