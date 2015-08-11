class AddUserToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :user_id, :string
    add_index :bookmarks, :user_id
  end
end
