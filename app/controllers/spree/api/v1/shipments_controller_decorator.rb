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

            def generate_scan_form
                easy_post_shipments = []
                params[:shipments].each do |shipment_id|
                    shipment = Spree::Shipment.readonly(true).friendly.find(shipment_id)
                    easy_post_shipment = shipment.easypost_shipment
                    easy_post_shipments.push(easy_post_shipment)
                end

                scan_form = ::EasyPost::ScanForm.create(shipments: easy_post_shipments)
                redirect_to scan_form.form_url
            end

        end
      end
    end
  end
  