class ChangeUserForGithubAuthentication < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false
    add_index :users, %i[provider uid], unique: true
    remove_column :users, :admin, :boolean, deffault: false, null: false
    remove_column :users, :password_digest, :string, null: false
  end
end
