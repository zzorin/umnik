Rails.application.routes.draw do
  root 'welcome#index'

  resources :contests do
    resources :nominations
  end
end
