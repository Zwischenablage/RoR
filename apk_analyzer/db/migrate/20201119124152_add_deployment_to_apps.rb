class AddDeploymentToApps < ActiveRecord::Migration[6.0]
  def change
    add_column :apps, :deployment, :string
  end
end
