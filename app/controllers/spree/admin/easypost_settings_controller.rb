module Spree
  module Admin
    class EasypostSettingsController < Spree::Admin::BaseController
      def edit
      end

      def update
        Spree::Config.buy_postage = easypost_settings_params[:buy_postage]
        Spree::Config.auto_capture_on_postage_buy = easypost_settings_params[:auto_capture_on_postage_buy]
        Spree::Config.easypost_validate_address = easypost_settings_params[:easypost_validate_address]

        redirect_to :back
      end

      private

      def easypost_settings_params
        params.require(:settings).permit(:buy_postage, :auto_capture_on_postage_buy, :easypost_validate_address)
      end
    end
  end
end
