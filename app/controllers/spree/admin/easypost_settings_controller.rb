module Spree
  module Admin
    class EasypostSettingsController < Spree::Admin::BaseController
      def edit
      end

      def update
        Spree::Config.buy_postage_when_shipped = easypost_settings_params[:buy_postage_when_shipped]
        Spree::Config.validate_address_with_easypost = easypost_settings_params[:validate_address_with_easypost]

        redirect_to :back
      end

      private

      def easypost_settings_params
        params.require(:settings).permit(:buy_postage_when_shipped, :validate_address_with_easypost)
      end
    end
  end
end
