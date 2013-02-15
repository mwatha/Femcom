class NewsController < ApplicationController
  def post
    @post = News.find(params[:id])
  end

end
