Spree::AppConfiguration.class_eval do
    preference :buy_postage, :boolean, default: false
    preference :auto_capture_on_postage_buy, :boolean, default: false # Captures payment for each shipment in Shipment#buy_easypost_rate callback, and buys rate when payment is authorized!
    preference :validate_address_with_easypost, :boolean, default: true
end
