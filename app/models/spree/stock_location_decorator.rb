Spree::StockLocation.class_eval do

    #alias the company name to the name of the stock location
    alias_attribute :company, :name
    
    has_many :scan_forms

    self.whitelisted_ransackable_associations = %w[shipments scan_forms]
    self.whitelisted_ransackable_attributes = %w[id time_zone admin_name]

end