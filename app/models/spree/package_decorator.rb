module Spree
  module Stock
    module PackageDecorator
      def easypost_parcel
        total_weight = contents.sum do |item|
          item.quantity * item.variant.weight
        end

        ::EasyPost::Parcel.create weight: total_weight
      end

      def use_easypost?
        shipping_categories.any? { |shipping_category| shipping_category.use_easypost }
      end

      def build_sku_list
        inventory_units = order.inventory_units
        inventory_units.map{|v| v.variant.sku }.join(", ")
      end

      def easypost_shipment
        ::EasyPost::Shipment.create(
          to_address: order.ship_address.easypost_address,
          from_address: stock_location.easypost_address,
          parcel: easypost_parcel,
          options: { print_custom_1: order.number, 
          print_custom_1_barcode: false,
          print_custom_2: build_sku_list, 
          print_custom_2_barcode: false},
        )
      end
    end
  end
end

Spree::Stock::Package.prepend Spree::Stock::PackageDecorator
