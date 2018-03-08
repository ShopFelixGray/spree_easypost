class RemoveNameFromSpreeShippingRates < ActiveRecord::Migration
  def change
    remove_column :spree_shipping_rates, :name, :string
  end
end
