Deface::Override.new(:virtual_path => "spree/admin/orders/_shipment",
:name => "add_buy_postage_to_order_shipment",
:insert_after => "[class='stock-location-name']",
:partial => "spree/admin/orders/buy_postage")