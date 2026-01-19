class StudyLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_log, only: [:edit, :update, :destroy]

  def index
    @study_logs = current_user.study_logs.order(created_at: :desc)
  end

  def new
    @study_log = StudyLog.new
  end

  def create
    @study_log = current_user.study_logs.build(study_log_params)

    if @study_log.save
      redirect_to study_logs_path, notice: '学習記録を投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @study_log.update(study_log_params)
      redirect_to study_logs_path, notice: '学習記録を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @study_log.destroy
    redirect_to study_logs_path, notice: '学習記録を削除しました'
  end

  private

  def set_study_log
    @study_log = current_user.study_logs.find(params[:id])
  end

  def study_log_params
    params.require(:study_log).permit(:title, :content)
  end
end
