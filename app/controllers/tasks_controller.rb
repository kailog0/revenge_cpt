# frozen_string_literal: true

class TasksController < ApplicationController
  protect_from_forgery except: %i[create update]

  TASK_UPPER_LIMIT = 5000
  ACCEPTABLE_URL_RE = %r{(https://atcoder.jp/|https://codeforces.com/)}

  def index
    if params[:solved_status].blank?
      render json: { message: "solved_statusパラメーターを指定してください。" }, status: 400
    elsif params[:from_x_days_ago].blank?
      render json: { message: "from_x_days_agoパラメーターを指定してください。" }, status: 400
    elsif params[:to_y_days_ago].blank?
      render json: { message: "to_y_days_agoパラメーターを指定してください。" }, status: 400
    else
      today = Time.zone.now
      from_day = Time.zone.parse((today - params[:from_x_days_ago].to_i.day).strftime("%F"))
      to_day = Time.zone.parse((today - params[:to_y_days_ago].to_i.-(1).day).strftime("%F"))
      tasks = Task.where(user_id: current_user.id).where(status: params[:solved_status]).where(updated_at: from_day...to_day)
      render json: tasks
    end
  end

  def show
    tasks = { url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_a',
              url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_b' }
    render json: { status: 'SUCCESS', data: tasks }
  end

  def create
    task = Task.new(task_params.merge({ user_id: current_user.id }))
    tasks_count = Task.where(user_id: current_user).count
    error_messages = []

    if task.url.match(ACCEPTABLE_URL_RE).nil?
      error_messages.push(ErrorHelper::TASK_NOT_PERMITTED_URL_ERROR_MESSAGE)
    end

    if TASK_UPPER_LIMIT <= tasks_count
      error_messages.push(ErrorHelper::TASK_UPPER_LIMIT_ERROR_MESSAGE)
    end

    if error_messages.empty? && TASK_UPPER_LIMIT > tasks_count && task.save
      render json: { message: '登録完了' }, status: 200
    else
      render json: { messages: error_messages }, status: 400
    end
  end

  def update
    task = Task.find(task_params[:id])
    if params[:mode] == "update"
      attributes = task_params.merge({ pre_updated_at: task.updated_at })
    elsif params[:mode] == "downgrade"
      attributes = task_params.merge({ updated_at: task.pre_updated_at })
    end
    if task.update(attributes)
      render json: { message: '更新完了しました。' }, status: 200
    else
      render json: { message: '登録に失敗しました。' }, status: 400
    end
  end

  private

  def task_params
    params.require(:task).permit(:id, :url, :status)
  end
end
