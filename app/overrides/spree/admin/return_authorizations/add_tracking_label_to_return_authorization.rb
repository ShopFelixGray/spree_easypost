Deface::Override.new(
    :virtual_path => "spree/admin/return_authorizations/index",
    :name => "add_tracking_label_to_return_authorization",
    :insert_top => "[class='actions actions-2']",
    :partial => "spree/admin/return_authorizations/customer_return_tracking"
)
  
