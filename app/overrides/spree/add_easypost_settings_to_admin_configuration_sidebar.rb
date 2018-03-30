Deface::Override.new(
    virtual_path: 'spree/admin/shared/sub_menu/_configuration',
    name: 'add_easypost_settings_to_admin_configuration_sidebar',
    insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
    text: '<%= configurations_sidebar_menu_item Spree.t(:easypost_settings), edit_admin_easypost_setting_path(id: "easypost_settings") %>'
)
