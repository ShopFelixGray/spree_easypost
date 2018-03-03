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
                stock_location = StockLocation.find_by(:id => params[:stock_location_id])
                time_in_zone = Time.now.in_time_zone(stock_location.time_zone)
                @shipments = Shipment.where({state: "shipped", 
                        shipped_at: time_in_zone.beginning_of_day..(time_in_zone.end_of_day), 
                        stock_location: stock_location, 
                        scan_form_id: nil})
                @easy_post_shipments = []
                @shipments.each do |shipment|
                    easy_post_shipment = shipment.easypost_shipment
                    @easy_post_shipments.push(easy_post_shipment)
                end
                    
                begin
                    @scan_form = ::EasyPost::ScanForm.create(shipments: @easy_post_shipments)
                    spree_scan_form = Spree::ScanForm.create(
                        easy_post_scan_form_id: @scan_form.id,
                        stock_location: stock_location,
                        scan_form: @scan_form.form_url)
                    @shipments.update_all(:scan_form_id => spree_scan_form.id)
                    render json: { scan_form: @scan_form.form_url }
                rescue ::EasyPost::Error => e
                    render json: e.json_body, :status => :bad_request                    
                end
            end

        end
      end
    end
  end
  