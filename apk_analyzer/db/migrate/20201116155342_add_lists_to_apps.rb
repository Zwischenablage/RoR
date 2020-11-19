class AddListsToApps < ActiveRecord::Migration[6.0]
  def change
    add_column :apps, :usedPermissionsList, :string
    add_column :apps, :createdPermissionsList, :string
    add_column :apps, :provdersList, :string
    add_column :apps, :receiversList, :string
    add_column :apps, :servicesList, :string
  end
end
