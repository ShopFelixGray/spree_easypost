Spree::ReturnAuthorization.class_eval do
  has_many :customer_shipments, class_name: "Spree::CustomerShipment", :dependent => :destroy

  attr_accessor :create_label
  attr_accessor :custom_weight

  after_create :buy_postage, if: :create_label

  state_machine.before_transition(
    to: :canceled,
    do: :customer_shipments_refund_labels
  )
        
  def buy_postage
    begin
      customer_shipments.create!
    rescue Exception => e
      errors.add(:base, e.message)
      raise ActiveRecord::Rollback
    end
  end

  def create_label
    @create_label == '1'
  end

  def custom_weight
    @custom_weight.to_f
  end

  def customer_shipments_refund_labels
    if customer_shipments.any?
      customer_shipments.each do |customer_shipment|
        customer_shipment.refund_label
      end
    end
  end

end
