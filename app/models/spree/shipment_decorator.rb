module Spree
  module ShipmentDecorator
    def self.prepended(mod)
      mod.state_machine.before_transition(
        to: :shipped,
        do: :buy_easypost_rate,
        if: -> { Spree::Config[:buy_postage] }
      )
    end

    def determine_state(order)
      return 'canceled' if order.canceled?
      return 'pending' unless order.can_ship?
      return 'pending' if inventory_units.any? &:backordered?
      return 'shipped' if shipped?
      order.paid? || Spree::Config[:auto_capture_on_postage_buy] ? 'ready' : 'pending'
    end

    def easypost_shipment
      if selected_easy_post_shipment_id
        @ep_shipment ||= ::EasyPost::Shipment.retrieve(selected_easy_post_shipment_id)
      else
        @ep_shipment = build_easypost_shipment
      end
    end


    def buy_easypost_rate
      process_order_payments if Spree::Config[:auto_capture_on_postage_buy]

      rate = easypost_shipment.rates.find do |rate|
        rate.id == selected_easy_post_rate_id
      end

      easypost_shipment.buy(rate) unless self.tracking?
      self.tracking = easypost_shipment.tracking_code
      self.tracking_label = easypost_shipment.postage_label.label_url
    end

    def build_custom_1
      order.number
    end

    def build_custom_2
      inventory_units = order.inventory_units
      inventory_units.map{|v| v.variant.sku }.join(", ")
    end

    private

    def selected_easy_post_rate_id
      selected_shipping_rate.easy_post_rate_id
    end

    def selected_easy_post_shipment_id
      selected_shipping_rate.easy_post_shipment_id
    end

    def build_easypost_shipment
      ::EasyPost::Shipment.create(
        to_address: order.ship_address.easypost_address,
        from_address: stock_location.easypost_address,
        parcel: to_package.easypost_parcel,
        options: { print_custom_1: build_custom_1, 
        print_custom_1_barcode: false,
        print_custom_2: build_custom_2,
        print_custom_2_barcode: false},
      )
    end

  end
end

Spree::Shipment.prepend Spree::ShipmentDecorator
