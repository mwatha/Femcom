module ApplicationHelper
  def latest_news
    News.order("created_at DESC").limit(4)
  end

  def latest_events
    Event.order("created_at DESC").limit(10)
  end

end
