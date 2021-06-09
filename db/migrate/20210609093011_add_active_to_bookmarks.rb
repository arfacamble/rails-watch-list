class AddActiveToBookmarks < ActiveRecord::Migration[6.1]
  def change
    add_column :bookmarks, :active, :boolean, default: false
  end
end
