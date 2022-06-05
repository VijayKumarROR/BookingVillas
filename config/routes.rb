Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :villas, only: :index do 

        get 'search_villas', on: :collection
        get 'available_villas', on: :collection
        
      end
    end
  end

end
