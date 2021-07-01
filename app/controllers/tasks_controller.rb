class TasksController < ApplicationController
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
end
