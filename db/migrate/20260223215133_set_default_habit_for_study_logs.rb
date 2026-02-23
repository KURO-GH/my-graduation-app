class SetDefaultHabitForStudyLogs < ActiveRecord::Migration[7.0]
  def up
    # まだ存在しない場合は初期習慣を作成
    default_habit = Habit.find_or_create_by!(name: "未分類", category: "その他")

    # 既存のstudy_logsすべてにhabit_idをセット
    StudyLog.where(habit_id: nil).update_all(habit_id: default_habit.id)
  end

  def down
    # 元に戻す場合はhabit_idをNULLに
    StudyLog.update_all(habit_id: nil)
  end
end
