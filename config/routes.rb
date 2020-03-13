Rails.application.routes.draw do
  root 'welcome#index'

  resources :contests do
    resources :nominations
    resources :criterions
    resources :participants
    resources :experts
  end

  resources :permissions
end
