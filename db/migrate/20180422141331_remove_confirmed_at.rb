class RemoveConfirmedAt < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :confirmed_at
  end
end
