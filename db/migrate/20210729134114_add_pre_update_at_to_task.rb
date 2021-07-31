class AddPreUpdateAtToTask < ActiveRecord::Migration[6.0]
  def up
    add_column :tasks, :pre_updated_at, :datetime, precision: 6
  end

  def down
    remove_column :tasks, :pre_updated_at
  end
end
