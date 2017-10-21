module Spree
    module Api
      module V1
        ShipmentsController.class_eval do
            
            def buy_postage
                find_and_update_shipment
                unless @shipment.tracking_label?
                    @shipment.buy_easypost_rate
                    @shipment.save!
                end
                respond_with(@shipment, default_template: :show)   
            end

        end
      end
    end
  end
  