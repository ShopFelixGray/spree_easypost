module Spree
  module Api
    module ApiHelpers
        ATTRIBUTES.push(:customer_shipment_attributes)

        @@customer_shipment_attributes = [:id, :number, :tracking, :tracking_label, :weight]
        
        @@shipment_attributes.push(:tracking_label)
    end
  end
end
