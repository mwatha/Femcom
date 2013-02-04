class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :perform_basic_auth, :except =>:login

  protected

  def perform_basic_auth
    if session[:user_id].blank?
      User.current_user = nil
    elsif not session[:user_id].blank?
      User.current_user = User.where(:'id' => session[:user_id]).first
    end
  end

end
