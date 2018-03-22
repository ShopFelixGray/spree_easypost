Deface::Override.new(:virtual_path => "spree/layouts/admin",
    :name => "add_scan_form_to_admin_submenu",
    :insert_bottom => "[data-hook='admin_tabs']",
    :disabled => false) do
        <<-HTML
        <% if can? :admin, Spree::ScanForm %>
            <ul class="nav nav-sidebar">
              <%= tab Spree::ScanForm, url: admin_scan_forms_url, icon: 'barcode', label: plural_resource_name(Spree::ScanForm) %>
            </ul>
          <% end %>
        HTML
end