Spree::AppConfiguration.class_eval do
    preference :buy_postage, :boolean, default: false
    preference :calculate_price, :boolean, default: false
end