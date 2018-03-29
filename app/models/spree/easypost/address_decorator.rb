module Spree
  module EasyPost
    module AddressDecorator
      def self.prepended(base)
        base.validate :easypost_address_validate
      end

      private 

      def easypost_address_validate
        verifications = easypost_address.verifications

        add_validation_errors(verifications.zip4.errors)
        add_validation_errors(verifications.delivery.errors)
      end

      def easypost_address
        attributes = {
          verify: ["delivery", "zip4"],
          street1: address1,
          street2: address2,
          city: city,
          zip: zipcode,
          phone: phone
        }

        attributes[:company] = company if respond_to?(:company)
        attributes[:name] = full_name if respond_to?(:full_name)
        attributes[:state] = state ? state.abbr : state_name
        attributes[:country] = country.try(:iso)

        ::EasyPost::Address.create attributes
      end

      def add_validation_errors(verification_errors)
        verification_errors.each do |err|
          err_code = err.try(:code)
          err_key_name = easypost_errors[err_code]

          errors.add(err_key_name, err.message) if err_key_name
        end
      end

      def easypost_errors
        {
          "E.HOUSE_NUMBER.MISSING" =>          :address1,
          "E.HOUSE_NUMBER.INVALID" =>          :address1,
          "E.STREET.MISSING" =>                :address1,
          "E.STREET.INVALID" =>                :address1,
          "E.BOX_NUMBER.MISSING" =>            :address1,
          "E.BOX_NUMBER.INVALID" =>            :address1,
          "E.SECONDARY_INFORMATION.INVALID" => :address2,
          "E.SECONDARY_INFORMATION.MISSING" => :address2,
          "E.ZIP.NOT_FOUND" =>                 :zipcode,
          "E.ZIP.INVALID" =>                   :zipcode,
          "E.ZIP.PLUS4.NOT_FOUND" =>           :zipcode,
          "E.CITY_STATE.INVALID" =>            :city,
          "E.STATE.INVALID" =>                 :state,
          "E.ADDRESS.DELIVERY.INVALID" =>      :address,
          "E.ADDRESS.INVALID" =>               :address,
          "E.ADDRESS.NOT_FOUND" =>             :address
        }
      end
    end
  end
end

Spree::Address.prepend Spree::EasyPost::AddressDecorator
Spree::StockLocation.prepend Spree::EasyPost::AddressDecorator

