Refinery::Core::Engine.routes.draw do

  # Admin routes
  namespace :service_options, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :service_options, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
