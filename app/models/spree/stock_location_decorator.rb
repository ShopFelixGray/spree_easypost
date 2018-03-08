Spree::StockLocation.class_eval do

    #alias the company name to the name of the stock location
    alias_attribute :company, :name
    
    has_many :scan_forms

end