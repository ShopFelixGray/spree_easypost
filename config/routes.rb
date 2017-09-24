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
      resources :orders do
        resources :return_authorizations do
          member do
            post :generate_return_label, to: 'shipping_labels#generate_return_label'
          end
        end
      end
    end
  end
end
