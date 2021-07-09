# frozen_string_literal: true

class TasksController < ApplicationController
  protect_from_forgery except: %i[create update]

  TASK_UPPER_LIMIT = 50

  def index
    tasks = Task.where(user_id: current_user.id).where(status: params[:solved_status])
    render json: tasks
  end

  def show
    tasks = { url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_a',
              url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_b' }
    render json: { status: 'SUCCESS', data: tasks }
  end

  def create
    task = Task.new(url: params[:url], user_id: current_user.id, status: 0)
    tasks_count = Task.where(user_id: current_user).count
    error_messages = []
    if TASK_UPPER_LIMIT <= tasks_count
      error_messages.push(ErrorHelper::TASK_UPPER_LIMIT_ERROR_MESSAGE)
    end

    if TASK_UPPER_LIMIT <= tasks_count && task.save
      render json: { message: '登録完了' }, status: 200
    else
      render json: { messages: %w[a b] }, status: 400
    end
  end

  def update
    task = Task.find(params[:id])

    if task.update(status: params[:status])
      render json: { message: '更新完了しました。' }, status: 201
    else
      render json: { message: '登録に失敗しました。' }, status: 400
    end
  end

  private

  def task_params
    params.require(:task).permit(:url, :status)
  end
end
