class TasksController < ApplicationController
  def index
    @tasks = { url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_a', url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_b'}
  end

  def show
    tasks = { url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_a', url: 'https://atcoder.jp/contests/zone2021/tasks/zone2021_b'}
    render json: { status: 'SUCCESS', data: tasks}
  end
end
