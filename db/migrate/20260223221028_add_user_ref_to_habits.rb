class AddUserRefToHabits < ActiveRecord::Migration[7.0]
  def change
    # まず null 許可で追加
    add_reference :habits, :user, foreign_key: true, null: true

    # 既存の habit に適当なユーザーを割り当て（例: id=1 のユーザー）
    execute "UPDATE habits SET user_id = 1"

    # null 不許可に変更
    change_column_null :habits, :user_id, false
  end
end
