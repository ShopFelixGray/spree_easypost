module Spree
  class ReturnLabel < ActiveRecord::Base
    after_create :generate_label!

    belongs_to :return_authorization
    
    has_one :order, through: :return_authorization
    has_one :stock_location, through: :return_authorization

    default_scope { order "created_at desc" }

    def generate_label!
      easypost_shipment.buy(:rate => easypost_shipment.lowest_rate) unless easypost_shipment.postage_label
      self.easypost_shipment_id = easypost_shipment.id
      self.tracking = easypost_shipment.tracking_code
      self.label_info = easypost_shipment.postage_label.label_url
      self.weight = easypost_shipment.parcel.weight
      save!
    end

    def refund_label
      easypost_shipment.refund
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
        options: { print_custom_1: order.number, 
                   print_custom_1_barcode: true,
                   print_custom_2: return_authorization.number, 
                   print_custom_2_barcode: true },
        is_return: true
      )
    end

    def build_parcel
      # The parcel should be the sum of all the items
      variants_for_ship = return_authorization.inventory_units.joins(:variant)

      ::EasyPost::Parcel.create(
        :weight => variants_for_ship.sum(:weight)
      )
    end



    #@allv.map { |u| u.weight = 8; u.width = 8.0; u.depth = 3; u.height = 3; u.save! }

  end
end
