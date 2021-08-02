# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :login_required

  def index; end
end
