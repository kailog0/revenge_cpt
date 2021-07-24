# frozen_string_literal: true

class AddNotNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :url, false
    change_column_null :tasks, :status, false
  end
end
