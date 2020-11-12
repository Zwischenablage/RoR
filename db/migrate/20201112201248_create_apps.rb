class CreateApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.string :filename
      t.string :package
      t.boolean :hasActivity
      t.boolean :hasRO
      t.integer :numOfReceviers
      t.integer :numOfServices
      t.integer :numOfProviders
      t.integer :createdPermissions
      t.integer :usedPermissions
      t.boolean :bootCompleted
      t.boolean :persistent
      t.boolean :hasApplication

      t.timestamps
    end
  end
end
