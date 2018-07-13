module Spree
    module Api
      module V1
        class EasypostWebhookController < Spree::Api::BaseController

            def update 
                if tracker?
                    @shipment = Spree::Shipments.find_by(tracking: tracking_code)

                    if @shipment
                        @shipment.delivery_state = status
                        @shipment.save!
                    end
                end
                render json: {},  status: :ok
            end

            def tracker?
                type == "Tracker"
            end

            def type
                params["result"]["object"]
            end

            def tracking_code
                params["result"]["tracking_code"]
            end

            def status
                params["result"]["status"]
            end
        end
      end
    end
end