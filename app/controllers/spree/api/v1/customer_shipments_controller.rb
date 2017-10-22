module Spree
  module Api
    class CustomerShipmentsController < Spree::Api::BaseController
    
      def create
        find_order
        authorize! :create, CustomerShipment
        @rma = @order.return_authorizations.find(params[:id])
        @customer_shipment = @rma.customer_shipments.create!
        redirect_to edit_admin_order_return_authorization_path(@order, @rma)
      end

      def index
        authorize! :index, CustomerShipment
        @CustomerShipments = CustomerShipment.ransack(params[:q]).result.page(params[:page]).per(params[:per_page])
        respond_with(@CustomerShipments)
      end

      private
        def find_order
          @order = Spree::Order.find_by!(number: params.fetch(:customer_shipment).fetch(:order_id))
          authorize! :read, @order
        end
    end
  end
end
