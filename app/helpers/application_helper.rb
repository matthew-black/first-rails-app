module ApplicationHelper
    #--Input: timestamp. Output: October 23, 2017--#
  def long_form_date(timestamps)
    timestamps.strftime('%B %e, %Y')
  end
    #--Input: timestamp. Output: 15:45--#
  def long_form_time(timestamp)
    timestamp.strftime('%l:%M %p')
  end
end
