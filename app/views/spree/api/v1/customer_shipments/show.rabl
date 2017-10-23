object @customer_shipment
attributes :id, :number, :tracking, :tracking_label, :weight, :created_at, :updated_at
node(:return_authorization) { |o| o.return_authorization }