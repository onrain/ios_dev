IOSmanager::Application.routes.draw do
  get 'admin' => "admin#index"

  resources :clients

  resources :companies

  # root :to => 'welcome#index'
end
