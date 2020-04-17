Rails.application.routes.draw do
  root 'dashboard#index'
  resource :users, only: [] do
    collection do
      get :search
    end
  end
  resources :contests do
    resources :nominations
    resources :criterions
    resources :participants do
      collection do
        get :by_nomination
      end
    end
    resources :experts do
      resources :marks
    end
  end

  resources :permissions, only: [:index, :create, :destroy] do
    collection do
      get :available_roles
    end
  end
end
