class CreateApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.string :filename
      t.string :package
      t.boolean :hasActivity
      t.bolean :hasRO
      t.integer :numOfServices
      t.integer :numOfReceivers
      t.integer :numOfProviders
      t.integer :createdPermissions
      t.integer :usedPermissions
      t.integer :bootCompleted
      t.integer :persistent

      t.timestamps
    end
  end
end
