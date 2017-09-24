module Spree
  module Api
    class ShippingLabelsController < Spree::Api::BaseController
      before_filter :find_order

      def generate_return_label
        @rma   = @order.return_authorizations.find(params[:id])
        @label = @rma.return_labels.create!
        redirect_to edit_admin_order_return_authorization_path(@order, @rma)
      end

      private
      def find_order
        @order = Spree::Order.where(number: params[:order_id]).first
      end
    end
  end
end
