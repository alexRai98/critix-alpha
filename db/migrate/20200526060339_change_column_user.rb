class ChangeColumnUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :unsername, :username
  end
end
