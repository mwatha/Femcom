class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :perform_basic_auth, :except =>:login


   def latest_news                                                               
     News.order("created_at DESC").limit(4)                                      
   end

  protected

  def perform_basic_auth
    if session[:user_id].blank?
      User.current_user = nil
      if action_name == 'admin'
        redirect_to '/'
      end
    elsif not session[:user_id].blank?
      User.current_user = User.where(:'id' => session[:user_id]).first
    end
  end

end
