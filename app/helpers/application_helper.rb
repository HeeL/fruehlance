module ApplicationHelper

  def nice_date(date)
    case date
    when Date.today
      'Today'
    when Date.yesterday
      'Yesterday'
    when 2.days.ago
      '2 days ago'
    else
      date.strftime('%d.%m.%Y')
    end
  end

end
