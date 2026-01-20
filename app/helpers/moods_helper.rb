module MoodsHelper
  def mood_emoji(level)
    {
      "very_good" => "🥰",
      "good"      => "🙂",
      "neutral"   => "😐",
      "bad"       => "😕",
      "very_bad"  => "😢"
    }[level]
  end

  def date_label(date)
    return "" if date.blank?

    date = date.to_date

    return "今日" if date == Date.current
    return "昨日" if date == Date.current - 1

    days_ago = (Date.current - date).to_i
    "#{days_ago}日前"
  end
end
