class Score < ActiveRecord::Base
  belongs_to :user

  class << self

    def today(user)
      today_score = 0
      today_array = user.scores.where("created_at >= ?", Date.today)
      today_array.each {|x| today_score += x[:score] }
      today_score
    end

    def weekly(user)
      weekly_score = 0
      week_array = user.scores.where("created_at >= ?", 1.week.ago.utc)
      week_array.each {|x| weekly_score += x[:score] }
      weekly_score
    end

    def monthly(user)
      monthly_score = 0
      month_array = user.scores.where("created_at >= ?", 1.month.ago.utc)
      month_array.each {|x| monthly_score += x[:score] }
      monthly_score
    end

    def all_time(user)
      all_time_score = 0
      user.scores.each { |x| all_time_score += x[:score]}
      all_time_score
    end 

  end

end