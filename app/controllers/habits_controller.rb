class HabitsController < ApplicationController
  def index
    @habits = current_user.habits.order(created_at: :desc)
  end

  def review
    habits = current_user.habits

    # カテゴリ一覧
    @categories = habits.pluck(:category).uniq

    # カテゴリで絞り込み
    habits = habits.where(category: params[:category]) if params[:category].present?

    # 完了/未完で絞り込み
    if params[:status].present?
      case params[:status]
      when "completed"
        habits = habits.where(completed: true)
      when "incomplete"
        habits = habits.where(completed: false)
      end
    end

    habits = habits.order(created_at: :desc)
    @habits_by_date = habits.group_by { |h| h.created_at.to_date }

    # 今週の達成率
    this_week = Date.current.beginning_of_week..Date.current.end_of_week
    week_habits = habits.select { |h| this_week.cover?(h.created_at.to_date) }
    @week_completion_rate =
      week_habits.any? ? (week_habits.count(&:completed).to_f / week_habits.size * 100).round : 0

    # 今月の達成率
    this_month = Date.current.beginning_of_month..Date.current.end_of_month
    month_habits = habits.select { |h| this_month.cover?(h.created_at.to_date) }
    @month_completion_rate =
      month_habits.any? ? (month_habits.count(&:completed).to_f / month_habits.size * 100).round : 0
  end

  def toggle_complete
    @habit = current_user.habits.find(params[:id])
    @habit.update(completed: !@habit.completed)

    habits = current_user.habits

    # 今週
    this_week = Date.current.beginning_of_week..Date.current.end_of_week
    week_habits = habits.select { |h| this_week.cover?(h.created_at.to_date) }
    @week_completion_rate =
      week_habits.any? ? (week_habits.count(&:completed).to_f / week_habits.size * 100).round : 0

    # 今月
    this_month = Date.current.beginning_of_month..Date.current.end_of_month
    month_habits = habits.select { |h| this_month.cover?(h.created_at.to_date) }
    @month_completion_rate =
      month_habits.any? ? (month_habits.count(&:completed).to_f / month_habits.size * 100).round : 0

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: review_habits_path) }
    end
  end
end
