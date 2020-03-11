Rails.application.routes.draw do
  root 'welcome#index'

  resources :contests do
    resources :nominations
  end

  resources :permissions, only: [:create, :index, :destroy]
end
