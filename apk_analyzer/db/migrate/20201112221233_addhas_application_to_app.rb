class AddhasApplicationToApp < ActiveRecord::Migration[6.0]
  def change
    add_column :apps, :hasApplication, :boolean
  end
end
