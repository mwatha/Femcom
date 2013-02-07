class NewsController < ApplicationController
  def post
    @post = News.find(params[:id])
    render :layout => false
  end

end
