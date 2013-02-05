module NewsHelper
  def print_news(str)
    str.gsub("\n", "<br />")
  end

end
