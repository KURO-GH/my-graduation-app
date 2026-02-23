class HabitsController < ApplicationController
  def index
    @habits = Habit.all.order(created_at: :desc)
  end

  def review
    # カテゴリ一覧取得（フォーム用）
    @categories = Habit.pluck(:category).uniq

    # ベースのHabit取得
    habits = Habit.all

    # カテゴリで絞り込む
    habits = habits.where(category: params[:category]) if params[:category].present?

    # 完了/未完フィルター
    if params[:status].present?
      case params[:status]
      when "completed"
        habits = habits.where(completed: true)
      when "incomplete"
        habits = habits.where(completed: false)
      end
    end

    # 作成日で降順
    habits = habits.order(created_at: :desc)

    # 日付ごとにまとめる
    @habits_by_date = habits.group_by { |h| h.created_at.to_date }

    # 今週の達成率
    this_week = Date.current.beginning_of_week..Date.current.end_of_week
    week_habits = habits.select { |h| this_week.cover?(h.created_at.to_date) }
    completed_count = week_habits.count { |h| h.completed }
    @week_completion_rate = week_habits.any? ? (completed_count.to_f / week_habits.size * 100).round : 0

    # 今月の達成率
    this_month = Date.current.beginning_of_month..Date.current.end_of_month
    month_habits = habits.select { |h| this_month.cover?(h.created_at.to_date) }
    completed_count_month = month_habits.count { |h| h.completed }
    @month_completion_rate = month_habits.any? ? (completed_count_month.to_f / month_habits.size * 100).round : 0
  end

  # 完了/未完を切り替えるアクション
  def toggle_complete
    @habit = Habit.find(params[:id])
    @habit.update(completed: !@habit.completed)
    redirect_back(fallback_location: habits_path)
  end
end
