class AddEasypostHsTariffNumberToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :easy_post_hs_tariff_number, :string
  end
end
