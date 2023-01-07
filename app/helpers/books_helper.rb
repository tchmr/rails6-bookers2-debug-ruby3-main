module BooksHelper
  # 比率を求める
  def culc_rate(current_count, previous_count)
    return 0 if previous_count == 0
    rate = current_count.to_f / previous_count
    (rate * 100).to_i
  end

  def all_last_week
    (Time.zone.now.ago(1.week + 6.days).beginning_of_day)..(Time.zone.now.ago(1.week).end_of_day)
  end

  def all_current_week
    (Time.zone.now.ago(6.days).beginning_of_day)..(Time.zone.now.end_of_day)
  end
end
