require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class EasypostRate < ShippingCalculator

      def self.description
        Spree.t(:shipping_easypost_rate_per_order)
      end

      def compute_package(package)
        raise NotImplementedError, "This should not be called. Please use the rate from the shipping method."
      end
      
    end
  end
end