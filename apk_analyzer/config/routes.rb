Rails.application.routes.draw do
  get 'aosp/index'
  get 'aosp/update'
  get 'aosp_gas/index'
  get 'aosp_gas/update'
  get 'polestar/index'
  get 'polestar/update'
  get 'apps/index'
  get 'apps/update'
  get 'apps/clean'
  get 'overview/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :apps

  root 'apps#index'
end
