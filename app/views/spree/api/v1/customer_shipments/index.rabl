object false
child(@customer_shipments => :customer_shipments) do
    extends "spree/api/v1/customer_shipments/show"
end
node(:count) { @customer_shipments.count }
node(:current_page) { params[:page].try(:to_i) || 1 }
node(:pages) { @customer_shipments.total_pages }