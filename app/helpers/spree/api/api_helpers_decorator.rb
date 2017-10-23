module Spree
  module Api
    module ApiHelpers
        mattr_reader :customer_shipment_attributes

        @@customer_shipment_attributes = [:id, :number, :return_authorization_id, :tracking, :tracking_label, :weight, :created_at, :updated_at]
        
        @@shipment_attributes.push(:tracking_label)
    end
  end
end
