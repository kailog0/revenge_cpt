class AddConstraintsToUser < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :name, :string, limit: 100, null: false
  end

  def down
    change_column :users, :name, :string, null: false
  end
end
