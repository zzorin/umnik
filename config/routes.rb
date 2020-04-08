Rails.application.routes.draw do
  root 'dashboard#index'

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
