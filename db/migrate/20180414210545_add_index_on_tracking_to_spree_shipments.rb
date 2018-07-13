class AddIndexOnTrackingToSpreeShipments < ActiveRecord::Migration
  def change
    add_index :spree_shipments, :tracking
  end
end
