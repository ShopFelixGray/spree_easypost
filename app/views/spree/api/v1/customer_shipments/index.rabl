object false
child(@customer_shipments => :customer_shipments) do
  attributes *customer_shipment_attributes
end
node(:count) { @customer_shipments.count }
node(:current_page) { params[:page].try(:to_i) || 1 }
node(:pages) { @customer_shipments.total_pages }