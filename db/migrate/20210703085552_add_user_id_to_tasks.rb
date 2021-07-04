class AddUserIdToTasks < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false
  end

  def down
    remove_reference :tasks, :user
  end
end
