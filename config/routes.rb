Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :surveys, only: [:show] do
        collection do
          post '/:id' => 'surveys#create'
        end
      end
    end
  end
end
