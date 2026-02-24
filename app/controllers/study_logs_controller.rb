# frozen_string_literal: true

class StudyLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_log, only: %i[edit update destroy]

  def index
    # 自分が見れる学習記録を取得
    @study_logs = policy_scope(StudyLog).order(created_at: :desc)
    
    # キーワード検索
    if params[:keyword].present?
      @study_logs = @study_logs.where("title LIKE :kw OR content LIKE :kw", kw: "%#{params[:keyword]}%")
    end

    # カテゴリ絞り込み
    if params[:category].present? && params[:category] != "全て"
      @study_logs = @study_logs.where(category: params[:category])
    end
  end

  def new
    @study_log = StudyLog.new
    authorize @study_log
  end

  def edit
    authorize @study_log
  end

  def create
    @study_log = current_user.study_logs.build(study_log_params)
    authorize @study_log

    # 投稿ごとに独立した Habit を作成して紐付け
    @study_log.build_habit(
      user: current_user,
      completed: false,
      name: @study_log.title,
      category: @study_log.category
    )

    if @study_log.save
      redirect_to study_logs_path, notice: '学習記録を投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @study_log

    if @study_log.update(study_log_params)
      redirect_to study_logs_path, notice: '学習記録を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @study_log
    @study_log.destroy
    redirect_to study_logs_path, notice: '学習記録を削除しました'
  end

  private

  def set_study_log
    @study_log = current_user.study_logs.find(params[:id])
  end

  def study_log_params
    params.require(:study_log).permit(:title, :content, :category)
  end
end
