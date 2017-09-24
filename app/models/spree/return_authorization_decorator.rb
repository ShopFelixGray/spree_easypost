Spree::ReturnAuthorization.class_eval do
  has_many :return_labels, class_name: "Spree::ReturnLabel"
end
