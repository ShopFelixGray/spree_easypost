Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resources :orders do
      resources :return_authorizations do
        resources :return_labels
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :customer_shipments do
        
      end

      resources :shipments do
        member do
          put :buy_postage
          put :buy_postage_ship
        end
      end

      post "/scan_form" => "shipments#scan_form"
    end
  end
end
