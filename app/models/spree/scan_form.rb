module Spree
    class ScanForm < Spree::Base
        belongs_to :stock_location
        has_many :shipments

        self.whitelisted_ransackable_associations = %w[stock_location shipments]
        self.whitelisted_ransackable_attributes = %w[scan_form]
    end
end
