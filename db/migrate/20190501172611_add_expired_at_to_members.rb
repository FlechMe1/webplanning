class AddExpiredAtToMembers < ActiveRecord::Migration
  def change
    add_column :members, :expired_at, :date
  end
end
