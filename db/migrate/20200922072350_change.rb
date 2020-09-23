class Change < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :nick_name, :string
  	add_column    :customers, :nick_name, :string
  	add_index :customers, :nick_name, :unique => true
  end
end
