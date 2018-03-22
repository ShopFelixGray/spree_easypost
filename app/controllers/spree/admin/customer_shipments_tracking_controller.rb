module Spree 
    module Admin
      class CustomerShipmentsTrackingController < ResourceController

        def index
          @tracking_number = params[:tracking]
          return if @tracking_number.nil?
          parse_tracking_nubmer
          @customer_shipment = Spree::CustomerShipment.find_by(tracking: @tracking_number)
          if @customer_shipment
            @order = @customer_shipment.return_authorization.order
            redirect_to new_admin_order_customer_return_path(@order)
          else
            flash[:notice] = "Could not find customer shipment."
          end
        end

        def parse_tracking_nubmer
          # USPS barcodes start with 420 and 5 digit zipcode
          # Need to remove the first 8 chars for this to work
          if @tracking_number.start_with?('420')
            @tracking_number = @tracking_number[8..-1]
          end
        end

        private

        def model_class
          Spree::CustomerShipment
        end
 
      end
    end
end