Rails.application.routes.draw do
  root 'welcome#index'

  resources :contests do
    resources :nominations
    resources :criterions
  end

  resources :permissions
end
