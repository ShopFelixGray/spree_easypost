class AddNumberToSpreeScanForms < ActiveRecord::Migration
  def change
    add_column :spree_scan_forms, :number, :string
  end
end
