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

  def source_image(source_name)
    image_file = "#{source_name}.png"
    alt = "Logo #{Offer.source_display_name(source_name)}"
    return '' unless File.exists?(Rails.root.join('app', 'assets', 'images', 'sources', image_file))
    image_tag "sources/#{image_file}", alt: alt, title: alt
  end

end
