class DropUsersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :users_table
  end
end
