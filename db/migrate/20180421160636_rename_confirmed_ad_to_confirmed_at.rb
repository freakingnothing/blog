class RenameConfirmedAdToConfirmedAt < ActiveRecord::Migration[5.2]
  def change
    rename_column(:users, :confirmed_ad, :confirmed_at)
  end
end
