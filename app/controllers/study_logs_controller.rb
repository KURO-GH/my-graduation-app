class StudyLogsController < ApplicationController
  before_action :authenticate_user!

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

  private

  def study_log_params
    params.require(:study_log).permit(:title, :content)
  end
end
