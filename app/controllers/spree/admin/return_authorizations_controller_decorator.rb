module Spree
    module Admin
      ReturnAuthorizationsController.class_eval do
  
        after_action :buy_postage, only: [:create]
        
        def buy_postage
            @return_authorization.customer_shipments.create
        end

      end
    end
  end
  