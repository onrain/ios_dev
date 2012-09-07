IOSmanager::Application.routes.draw do

  get 'admin' => "admin#index"

  get '/admin/handle/:id' => "clients#handle", as:"handle"
  post '/admin/handle/:id' => "clients#handle"
  delete '/admin/remove/:id' => "clients#remove"

  match 'admin/*applications/:id' => 'applications#show'
  match 'admin/applications' => "applications#index"

  scope "/admin" do
    resources :clients
    resources :companies
    resources :managers
    resources :developers
    resources :projects
    resources :applications
  end
  match "*path", :to => "application#routing_error"

  # root :to => 'welcome#index'
end
