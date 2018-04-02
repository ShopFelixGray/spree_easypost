module SpreeEasypost
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_easypost'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree.easypost.preferences', before: :load_config_initializers do |app|
     Spree::AppConfiguration.class_eval do
       preference :buy_postage_when_shipped, :boolean, default: false
       preference :auto_capture_on_postage_buy, :boolean, default: false # Captures payment for each shipment in Shipment#buy_easypost_rate callback, and buys rate when payment is authorized!
       preference :validate_address_with_easypost, :boolean, default: false
       preference :customs_signer, :string, default: ''
       preference :customs_contents_type, :string, default: 'merchandise'
       preference :customs_eel_pfc, :string, default: 'NOEEI 30.37(a)'
     end
   end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
