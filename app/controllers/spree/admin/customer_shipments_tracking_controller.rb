module Spree 
    module Admin
      class CustomerShipmentsTrackingController < ResourceController

        def index
          @customer_shipment = Spree::CustomerShipment.find_by(tracking: params[:tracking])
          if @customer_shipment
            @order = @customer_shipment.return_authorization.order
            redirect_to new_admin_order_customer_return_path(@order)
          end
        end

        private

        def model_class
          Spree::CustomerShipment
        end
 
      end
    end
end