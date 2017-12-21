class AddEasyPostFieldsToShippingCategory < ActiveRecord::Migration
  def change
    add_column :spree_shipping_categories, :use_easypost, :boolean, default: false
  end
end
