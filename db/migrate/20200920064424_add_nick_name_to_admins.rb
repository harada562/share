class AddNickNameToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :nick_name, :string
  end
end
