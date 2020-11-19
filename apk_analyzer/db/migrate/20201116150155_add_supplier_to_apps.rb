class AddSupplierToApps < ActiveRecord::Migration[6.0]
  def change
    add_column :apps, :supplier, :string
  end
end
