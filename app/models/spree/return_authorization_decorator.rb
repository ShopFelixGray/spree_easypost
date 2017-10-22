Spree::ReturnAuthorization.class_eval do
  has_many :customer_shipments, class_name: "Spree::CustomerShipment", :dependent => :destroy

  state_machine.before_transition(
    to: :canceled,
    do: :customer_shipments_refund_labels
  )
 

  def customer_shipments_refund_labels
    if customer_shipments.any?
      customer_shipments.each do |customer_shipment|
        customer_shipment.refund_label
      end
    end
  end

end
