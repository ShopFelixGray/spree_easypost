module Spree
    class ScanForm < Spree::Base
        include Spree::Core::NumberGenerator.new(prefix: 'SF', length: 11)

        extend FriendlyId
        friendly_id :number, slug_column: :number, use: :slugged

        belongs_to :stock_location
        has_many :shipments

        self.whitelisted_ransackable_associations = %w[stock_location shipments]
        self.whitelisted_ransackable_attributes = %w[scan_form]
    end
end
