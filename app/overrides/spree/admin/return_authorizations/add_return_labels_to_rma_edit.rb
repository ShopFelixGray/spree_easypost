Deface::Override.new(
  :virtual_path => "spree/admin/return_authorizations/edit",
  :name => "add_return_labels_to_rma_edit",
  :insert_before => "erb[loud]:contains('form_for'):contains('@return_authorization')",
  :partial => "spree/admin/return_authorizations/return_shipping_labels"
)
