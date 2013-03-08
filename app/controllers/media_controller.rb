class MediaController < ApplicationController
  def videos
    @videos = YoutubeLinks.order("created_at DESC")
    @page_heading = 'Videos'
  end

end
