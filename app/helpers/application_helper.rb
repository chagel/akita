module ApplicationHelper
	def format_date(time)
    time.strftime("%Y-%m-%d")
  end

  def format_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def beauty_time(time)
    if Time.now.ago(60*60*24) > time
      "#{time.strftime("%m-%d %H:%M")}".html_safe
    else
      "#{distance_of_time_in_words_to_now(time)} ago"
    end
  end
end
