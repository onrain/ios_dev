IOSmanager::Application.routes.draw do

  get 'admin' => "admin#index"

  get '/admin/handle/:id', to:"clients#handle"
  post '/admin/handle/:id' => "clients#handle"
  delete '/admin/remove/:id' => "clients#remove"

  scope "/admin" do
    resources :clients
    resources :companies
    resources :managers
    resources :developers
    resources :projects
    resources :applications
  end


  # root :to => 'welcome#index'
end
