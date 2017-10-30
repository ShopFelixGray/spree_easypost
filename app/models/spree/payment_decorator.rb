module Spree
  Payment.class_eval do

      def split_uncaptured_amount
        if uncaptured_amount > 0
          @split_payment = order.payments.create! amount: uncaptured_amount,
                                 payment_method: payment_method,
                                 source: source,
                                 state: 'pending'
          @split_payment.authorize!
          update_attributes(amount: captured_amount)
        end
      end
    end
end