class RemoveIsActiveFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_active, :boolean
  end
end
