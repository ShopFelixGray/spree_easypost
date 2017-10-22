Spree::ReturnAuthorization.class_eval do
  has_many :customer_shipments, class_name: "Spree::CustomerShipment"
end
