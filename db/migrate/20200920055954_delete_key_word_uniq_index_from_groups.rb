class DeleteKeyWordUniqIndexFromGroups < ActiveRecord::Migration[5.2]
  def change
  	remove_index :groups, :key_word
  end
end
