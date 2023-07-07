class AddColumnRoleTouser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, null: false, default: 'user', index: true
  end
end
