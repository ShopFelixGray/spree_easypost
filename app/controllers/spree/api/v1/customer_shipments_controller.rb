module Spree
  module Api
    module V1
      class CustomerShipmentsController < Spree::Api::BaseController

        before_action :find_customer_shipment, except: [:index]

        def show
          authorize! :show, @customer_shipment
          respond_with(@customer_shipment)
        end

        def index
          authorize! :index, CustomerShipment
          @customer_shipments = CustomerShipment.ransack(params[:q]).result.page(params[:page]).per(params[:per_page])
          respond_with(@customer_shipments)
        end

        private

        def find_customer_shipment
          @customer_shipment = Spree::CustomerShipment.friendly.find(params[:id])
        end

        def customer_shipment_params
          params.require(:customer_shipment).permit(permitted_customer_shipment_attributes)
        end
      end
    end
  end
end
