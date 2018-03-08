class AddScanFormToShipments < ActiveRecord::Migration
  def change
    add_reference :spree_shipments, :scan_form, index: true
  end
end
