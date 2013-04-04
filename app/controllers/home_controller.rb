class HomeController < ApplicationController
  def index
    @contents = HomeContentPost.order("created_at")
    @page_heading = "Home"
  end

end
