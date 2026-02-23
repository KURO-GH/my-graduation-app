class SetDefaultHabitForStudyLogs < ActiveRecord::Migration[7.0]
  def up
    # 既存の StudyLog すべてをループ
    StudyLog.find_each do |log|
      next if log.habit.present?  # すでに紐付いている場合はスキップ

      # 各 StudyLog に紐づく Habit を作成
      Habit.create!(
        user: log.user,
        study_log: log,
        completed: false
      )
    end
  end

  def down
    # 元に戻す場合は、習慣を削除
    Habit.where(completed: false).destroy_all
  end
end
