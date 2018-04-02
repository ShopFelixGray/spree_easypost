Spree::Shipment.class_eval do

    belongs_to :scan_form, class_name: 'Spree::ScanForm'

    self.state_machine.before_transition(
      to: :shipped,
      do: :buy_easypost_rate,
      if: -> { Spree::Config[:buy_postage_when_shipped] }
    )

    def determine_state(order)
      return 'canceled' if order.canceled?
      return 'pending' unless order.can_ship?
      return 'pending' if inventory_units.any? &:backordered?
      return 'shipped' if shipped?
      order.paid? || Spree::Config[:auto_capture_on_postage_buy] ? 'ready' : 'pending'
    end

    def process_order_payments
      pending_payments =  order.pending_payments
                            .sort_by(&:uncaptured_amount).reverse

      shipment_to_pay = final_price_with_items
      payments_amount = 0

      payments_pool = pending_payments.each_with_object([]) do |payment, pool|
        break if payments_amount >= shipment_to_pay
        payments_amount += payment.uncaptured_amount
        pool << payment
      end

      payments_pool.each do |payment|
        begin
          capturable_amount = if payment.amount >= shipment_to_pay
                                shipment_to_pay
                              else
                                payment.amount
                              end

          cents = (capturable_amount * 100).to_i
          payment.capture!(cents)
          shipment_to_pay -= capturable_amount
        rescue Spree::Core::GatewayError => e
          payment.repurchase!
        end
      end
    end

    def easypost_shipment
      if selected_easy_post_shipment_id
        @ep_shipment ||= ::EasyPost::Shipment.retrieve(selected_easy_post_shipment_id)
      else
        @ep_shipment = build_easypost_shipment
      end
    end


    def buy_easypost_rate
      raise "can only buy postage when order is ready" unless (self.state == 'ready' || self.state == 'shipped')

      # regenerate the rates so we get updated data
      refresh_rates(Spree::ShippingMethod::DISPLAY_ON_FRONT_AND_BACK_END)
      @ep_shipment = nil

      # Process payments if auto capture was off
      process_order_payments if Spree::Config[:auto_capture_on_postage_buy]

      # Get the selected rate
      rate = easypost_shipment.rates.find do |rate|
        rate.id == selected_easy_post_rate_id
      end

      # Purchase the postage unless it was purchased before
      easypost_shipment.buy(rate) unless self.tracking?
      self.tracking = easypost_shipment.tracking_code
      self.tracking_label = easypost_shipment.postage_label.label_url
    end

    private

    def selected_easy_post_rate_id
      self.selected_shipping_rate.easy_post_rate_id
    end

    def selected_easy_post_shipment_id
      self.selected_shipping_rate.easy_post_shipment_id
    end

    def build_easypost_shipment
      ep_package = to_package
      ::EasyPost::Shipment.create(
        to_address: order.ship_address.easypost_address,
        from_address: stock_location.easypost_address,
        parcel: ep_package.easypost_parcel,
        customs_info: ep_package.easypost_customs_info,
        options: {
          print_custom_1: ep_package.ref_number,
          print_custom_1_barcode: true,
          print_custom_2: ep_package.build_sku_list,
          print_custom_2_barcode: false 
        },
      )
    end
end
