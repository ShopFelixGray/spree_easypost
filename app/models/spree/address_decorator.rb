Spree::Address.class_eval do
  validate :state_validate, :postal_code_validate, if: :use_spree_validations?

  private

  def use_spree_validations?
    # if Spree::Config.validate_address_with_easypost is set to true then we do not want to run Spree's built-in validations
    !Spree::Config.validate_address_with_easypost
   end
end