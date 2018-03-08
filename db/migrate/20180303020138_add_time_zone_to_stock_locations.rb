class AddTimeZoneToStockLocations < ActiveRecord::Migration
  def change
    add_column :spree_stock_locations, :time_zone, :string, :default => "UTC"
  end
end
