module Spree
  module Admin
    class EasypostSettingsController < Spree::Admin::BaseController
      def edit
      end

      def update
        update_easypost_settings

        redirect_to :back
      end

      private

      def update_easypost_settings
        easypost_settings_params.each do |key, value|
          Spree::Config[key] = value
        end
      end

      def easypost_settings_params
        params.require(:settings).permit(
            :buy_postage_when_shipped,
            :validate_address_with_easypost,
            :use_easypost_on_frontend,
            :customs_signer,
            :customs_contents_type,
            :customs_eel_pfc
        )
      end
    end
  end
end
