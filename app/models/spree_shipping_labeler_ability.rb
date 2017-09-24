class SpreeShippingLabelerAbility
  include CanCan::Ability
  def initialize(user)
    can :manage, Spree::ReturnAuthorization do |rma|
      user.admin?
    end
  end
end

Spree::Ability.register_ability(SpreeShippingLabelerAbility)
