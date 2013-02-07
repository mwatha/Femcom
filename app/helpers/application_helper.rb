module ApplicationHelper
  def latest_news
    News.order("created_at DESC").limit(4)
  end

end
