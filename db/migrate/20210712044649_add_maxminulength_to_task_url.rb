class AddMaxminulengthToTaskUrl < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :url, :string, limit: 255, null: false
  end

  def down
    change_column :tasks, :url, :string, null: false
  end
end
