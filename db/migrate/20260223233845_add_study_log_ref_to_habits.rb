class AddStudyLogRefToHabits < ActiveRecord::Migration[7.0]
  def change
    # まず null 許可で追加
    add_reference :habits, :study_log, foreign_key: true, null: true

    # 既存レコードに仮の StudyLog を割り当てる
    # 注意: ここで id=1 の StudyLog が存在する前提
    execute "UPDATE habits SET study_log_id = 1"

    # null 不許可に変更
    change_column_null :habits, :study_log_id, false
  end
end
