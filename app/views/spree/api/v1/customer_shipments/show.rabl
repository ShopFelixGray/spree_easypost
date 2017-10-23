object @customer_shipment
attributes *customer_shipment_attributes
node(:return_authorization) { |o| o.return_authorization }
node(:order_number) { |o| o.return_authorization.order.number }