class MediaController < ApplicationController
  def videos
    @videos = YoutubeLinks.all
  end

end
