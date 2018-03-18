Deface::Override.new(
    virtual_path: 'spree/admin/shared/sub_menu/_returns',
    name: 'add_customer_shipment_tracking_returns_sidebar',
    insert_bottom: '[data-hook="admin_returns_sub_tabs"]',
    text: '<%= tab :tracking_search, url: spree.admin_customer_shipments_tracking_index_path %>'
)