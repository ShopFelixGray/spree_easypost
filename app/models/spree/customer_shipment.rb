module Spree
  class CustomerShipment < Spree::Base
    include Spree::Core::NumberGenerator.new(prefix: 'CS', length: 11)

    extend FriendlyId
    friendly_id :number, slug_column: :number, use: :slugged

    before_create :generate_label
    before_destroy :refund_label

    belongs_to :return_authorization
    
    has_one :order, through: :return_authorization
    has_one :stock_location, through: :return_authorization

    self.whitelisted_ransackable_associations = %w[return_authorization]
    self.whitelisted_ransackable_attributes = %w[number tracking]

    def generate_label
      easypost_shipment.buy(:rate => easypost_shipment.lowest_rate) unless easypost_shipment.postage_label
      self.easypost_shipment_id = easypost_shipment.id
      self.tracking = easypost_shipment.tracking_code
      self.tracking_label = easypost_shipment.postage_label.label_url
      self.weight = easypost_shipment.parcel.weight
    end

    def refund_label
      begin
        easypost_shipment.refund
      rescue
        puts 'could not refund label!'
      end
      return true
    end

    private

    def easypost_shipment
      if easypost_shipment_id
        @ep_shipment ||= ::EasyPost::Shipment.retrieve(easypost_shipment_id)
      else
        @ep_shipment ||= build_easypost_shipment
      end
    end

    def build_easypost_shipment
      ::EasyPost::Shipment.create(
        from_address: stock_location.easypost_address,
        to_address: order.ship_address.easypost_address,
        parcel: build_parcel,
        options: { print_custom_1: order.number + " // " + return_authorization.number, 
                   print_custom_1_barcode: false,
                   print_custom_2: build_sku_list, 
                   print_custom_2_barcode: false},
        is_return: true
      )
    end

    def build_parcel
      # The parcel should be the sum of all the items
      variants_for_return = return_authorization.inventory_units.joins(:variant)

      ::EasyPost::Parcel.create(
        :weight => variants_for_return.sum(:weight)
      )
    end

    def build_sku_list
      inventory_units = return_authorization.inventory_units
      inventory_units.map{|v| v.variant.sku }.join(", ")
    end

    #@allv.map { |u| u.weight = 8; u.width = 8.0; u.depth = 3; u.height = 3; u.save! }

  end
end
