module Spree
  module ShippingRateDecorator
    def name
      read_attribute(:name) || super
    end
  end
end

Spree::ShippingRate.prepend Spree::ShippingRateDecorator
