module Spree
  module Admin
    class EasypostSettingsController < Spree::Admin::BaseController
      def edit
      end

      def update
        Spree::Config.buy_postage_when_shipped = easypost_settings_params[:buy_postage_when_shipped]
        Spree::Config.validate_address_with_easypost = easypost_settings_params[:validate_address_with_easypost]
        Spree::Config.use_easypost_on_frontend = easypost_settings_params[:use_easypost_on_frontend]
        redirect_to :back
      end

      private

      def easypost_settings_params
        params.require(:settings).permit(:buy_postage_when_shipped, :validate_address_with_easypost, :use_easypost_on_frontend)
      end
    end
  end
end
