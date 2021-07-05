class TasksController < ApplicationController
  protect_from_forgery except: :create
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
    if task.save
      render json: {'message': '登録完了'}, status: 200
    else
      head :bad_request
    end
  end
end
