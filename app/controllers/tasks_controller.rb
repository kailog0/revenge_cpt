class TasksController < ApplicationController
  protect_from_forgery except: :create

  TASK_UPPER_LIMIT = 5000;

  def index
    render json: {tasks: [
                 {"id": 1, "url": "https://kai2020.blog"},
                 {"id": 2, "url": "https://kai2020.blog"},
                 {"id": 3, "url": "https://kai2020.blog"},
    ]}
  end

  def show
    tasks = { url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_a', url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_b'}
    render json: { status: 'SUCCESS', data: tasks}
  end

  def create
    task = Task.new(url: params[:url], user_id: current_user.id, status: 0)
    tasks_count = Task.where(user_id: current_user).count
    error_messages = []
    if TASK_UPPER_LIMIT >= tasks_count 
      error_messages.push(ErrorHelper::TASK_UPPER_LIMIT_ERROR_MESSAGE)
    end

    if TASK_UPPER_LIMIT > tasks_count && task.save
      render json: {'message': '登録完了'}, status: 200
    else
      head :bad_request
    end
  end
end
