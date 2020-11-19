class AddProjectToApps < ActiveRecord::Migration[6.0]
  def change
    add_column :apps, :project, :string
  end
end
