class NewsController < ApplicationController
  def post
    @post = News.find(params[:id])
    @page_heading = @post.title
  end

end
