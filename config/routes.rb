Rails.application.routes.draw do
  root 'welcome#index'

  resources :contests do
    resources :nominations
    resources :criterions
    resources :participants
  end

  resources :permissions
end
