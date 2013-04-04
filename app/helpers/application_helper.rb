module ApplicationHelper
  def latest_news
    News.order("created_at DESC").limit(4)
  end

  def latest_events
    Event.order("created_at DESC").limit(10)
  end

  def print_news(str)                                                           
    str.gsub("\n", "<br />")                                                    
  end 

  def current_focus_and_activities        
    CurrentFocusAndActivities.order("created_at DESC").limit(3)
  end 

  def service_title     
    Services.order("created_at DESC").first.title rescue nil
  end 


end
