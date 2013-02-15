class MediaController < ApplicationController
  def videos
    @videos = YoutubeLinks.all
    @page_heading = 'Videos'
  end

end
