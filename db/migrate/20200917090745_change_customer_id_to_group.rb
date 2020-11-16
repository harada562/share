class ChangeCustomerIdToGroup < ActiveRecord::Migration[5.2]
  	 # 変更内容
  def up
    change_column :groups, :customer_id, :integer, :null => false
  end

  # 変更前の状態
  def down
    change_column :groups, :customer_id, :integer
  end
end
