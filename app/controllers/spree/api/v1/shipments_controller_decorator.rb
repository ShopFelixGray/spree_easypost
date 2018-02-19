module Spree
    module Api
      module V1
        ShipmentsController.class_eval do
            
            def buy_postage
                begin
                    find_and_update_shipment
                    unless @shipment.tracking_label?
                        @shipment.buy_easypost_rate
                        @shipment.save!
                        unless @shipment.shipped?
                            @shipment.ship!
                        end
                    end
                    respond_with(@shipment, default_template: :show)
                rescue
                    render :nothing => true, :status => :bad_request
                end
            end

            def scan_form
                @easy_post_shipments = []
                @easy_post_failed_shipments = []
                params[:shipments].each do |shipment_id|
                    begin
                        shipment = Spree::Shipment.accessible_by(current_ability, :read).readonly(true).friendly.find(shipment_id)
                        easy_post_shipment = shipment.easypost_shipment
                        @easy_post_shipments.push(easy_post_shipment)
                    rescue
                        @easy_post_failed_shipments.push(shipment_id)
                    end
                end
                
                begin
                    @scan_form = ::EasyPost::ScanForm.create(shipments: @easy_post_shipments)
                    render json: { scan_form: @scan_form.form_url, failed_shipments: @easy_post_failed_shipments}
                rescue ::EasyPost::Error => e
                    render json: e.json_body, :status => :bad_request
                end

            end
        end
      end
    end
  end
  