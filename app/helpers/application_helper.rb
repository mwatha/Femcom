module ApplicationHelper
  def latest_news
    News.order("created_at DESC").limit(7)
  end

end
