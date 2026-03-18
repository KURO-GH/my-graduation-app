# app/controllers/habits_controller.rb
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

    # 今週・今月の達成率
    @week_completion_rate = calculate_completion_rate(habits, :week)
    @month_completion_rate = calculate_completion_rate(habits, :month)
  end

  def toggle_complete
    Rails.logger.debug "🔥 toggle_complete通った"

    @habit = current_user.habits.find(params[:id])

    # 変更前の状態を保存
    before = @habit.completed

    # 完了状態を切り替え
    @habit.toggle!(:completed)

    # 「未完 → 完了」になった時だけ通知
    if !before && @habit.completed
      notification = Notification.create!(
        user: current_user,
        message: "#{@habit.name} を完了しました！",
        read: false
      )

      ActionCable.server.broadcast(
        "notification_channel_#{current_user.id}",
        {
          id: notification.id,
          message: notification.message
        }
      )
    end

    # 今週・今月の達成率再計算
    habits = current_user.habits
    @week_completion_rate = calculate_completion_rate(habits, :week)
    @month_completion_rate = calculate_completion_rate(habits, :month)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("habit-#{@habit.id}", partial: "habits/habit", locals: { habit: @habit }),
          turbo_stream.replace(
            "completion-rates",
            partial: "habits/completion_rates",
            locals: {
              week_completion_rate: @week_completion_rate,
              month_completion_rate: @month_completion_rate
            }
          )
        ]
      end

      format.html { redirect_back(fallback_location: review_habits_path) }
    end
  end

  private

  def calculate_completion_rate(habits, period)
    range =
      case period
      when :week
        Date.current.beginning_of_week..Date.current.end_of_week
      when :month
        Date.current.beginning_of_month..Date.current.end_of_month
      end

    filtered = habits.select { |h| range.cover?(h.created_at.to_date) }
    return 0 if filtered.empty?

    (filtered.count(&:completed).to_f / filtered.size * 100).round
  end
end
