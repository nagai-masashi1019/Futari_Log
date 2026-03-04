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

    return I18n.t("moods.helper.today") if date == Date.current
    return I18n.t("moods.helper.yesterday") if date == Date.current - 1

    days_ago = (Date.current - date).to_i
    I18n.t("moods.helper.days_ago", count: days_ago)
  end
end
