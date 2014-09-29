class AddAuthrocketIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authrocket_id, :string
    add_index  :users, :authrocket_id
  end
end