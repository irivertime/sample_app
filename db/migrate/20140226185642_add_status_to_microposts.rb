class AddStatusToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :status, :integer
  end
end
