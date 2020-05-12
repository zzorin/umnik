Rails.application.routes.draw do
  root 'dashboard#index'
  get 'instruction', to: 'dashboard#instruction'
  %w(administrator university_manager expert participant).each do |key|
    namespace(key) { root to: 'spa#index' }
  end
  resource :users, only: [] do
    collection do
      get :search
    end
  end
  resources :contests do
    get 'generate_rate_list'
    get 'generate_protocol'
    resources :nominations
    resources :criterions
    resources :participants do
      collection do
        get :by_nomination
        get :by_nomination_results
        get :for_results
      end
    end
    resources :marks, only: [:index] do
      member do
        get :history
      end
    end
    resources :experts do
      collection do
        get :for_results
      end
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
