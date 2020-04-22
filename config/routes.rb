Rails.application.routes.draw do
  root 'dashboard#index'
  %w(administrator university_manager expert).each do |key|
    namespace(key) { root to: 'spa#index' }
  end
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
    resources :marks, only: [:index]
    resources :experts do
      resources :marks, only: [:create, :update] do
        collection do
          get :by_participant
        end
      end
    end
  end

  resources :permissions, only: [:index, :create, :destroy] do
    collection do
      get :available_roles
    end
  end
end
