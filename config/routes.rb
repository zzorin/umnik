Rails.application.routes.draw do
  root 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :contests, only: [] do
        collection do
          get :all
        end
      end
    end
  end

  resources :contests do
    resources :nominations
    resources :criterions
    resources :participants
    resources :experts do
      resources :marks
    end
  end

  resources :permissions
end
