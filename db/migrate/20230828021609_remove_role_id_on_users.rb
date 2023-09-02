class RemoveRoleIdOnUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :role_id
    remove_column :users, :role_id
  end
end
