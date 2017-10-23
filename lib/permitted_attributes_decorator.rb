module Spree
   module PermittedAttributes

        mattr_reader :customer_shipment_attributes
        
        @@customer_shipment_attributes = [:tracking, :tracking_label, :weight]
        
        @@shipment_attributes.push(:tracking_label)
  end
end