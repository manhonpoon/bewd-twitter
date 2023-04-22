class AddIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, username, :string, index: true
    add_index :users, :email
  end
end
