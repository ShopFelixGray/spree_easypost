Deface::Override.new(
  :virtual_path => "spree/admin/return_authorizations/edit",
  :name => "add_customer_returns_to_rma_edit",
  :insert_before => "erb[loud]:contains('form_for'):contains('@return_authorization')",
  :partial => "spree/admin/return_authorizations/customer_returns"
)
