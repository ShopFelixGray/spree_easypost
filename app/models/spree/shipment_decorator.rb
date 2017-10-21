module Spree
  module ShipmentDecorator
    def self.prepended(mod)
      mod.state_machine.before_transition(
        to: :shipped,
        do: :buy_easypost_rate,
        if: -> { Spree::Config[:buy_postage] }
      )
    end

    def easypost_shipment
      if selected_easy_post_shipment_id
        @ep_shipment ||= ::EasyPost::Shipment.retrieve(selected_easy_post_shipment_id)
      else
        @ep_shipment = build_easypost_shipment
      end
    end

    def buy_easypost_rate
      rate = easypost_shipment.rates.find do |rate|
        rate.id == selected_easy_post_rate_id
      end

      easypost_shipment.buy(rate) unless self.tracking?
      self.tracking = easypost_shipment.tracking_code
      self.tracking_label = easypost_shipment.postage_label.label_url
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
        parcel: to_package.easypost_parcel
      )
    end
  end
end

Spree::Shipment.prepend Spree::ShipmentDecorator
