Rails.application.routes.draw do
  get 'apps/index'
  get 'overview/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :apps

  root 'apps#index'
end
