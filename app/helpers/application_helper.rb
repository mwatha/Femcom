module ApplicationHelper
  def latest_news
    News.order("created_at DESC").where("voided IS NULL").limit(4)
  end

  def latest_events
    Event.order("created_at DESC").limit(10)
  end

  def print_news(str)                                                           
    return '' if str.blank?     
    str.html_safe.gsub(/\r\n?/,"<br/>") 
  end 

  def current_focus_and_activities        
    CurrentFocusAndActivities.order("created_at DESC").limit(3)
  end 

  def service_title     
    Services.order("created_at DESC").first.title rescue nil
  end 

  def femcom_partners                                                          
    Partners.order('created_at ASC').where("logo IS NOT NULL").limit(3)        
  end

  def directors_pictures
    Directors.where("picture IS NOT NULL").collect{|d|d.picture}
  end

end
