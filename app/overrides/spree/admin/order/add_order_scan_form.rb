Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name: 'add_scan_form_modal',
  insert_after: '#listing_orders',
  text: '<%= render "spree/admin/orders/scan_form_modal" %>'
)

Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name: 'add_scan_form_button',
  insert_before: '[data-hook="admin_orders_index_search"]',
  text: '<%= render "spree/admin/orders/scan_form_button" %>'
)