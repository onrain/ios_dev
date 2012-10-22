IOSmanager::Application.routes.draw do

  devise_for :admins

  get 'admin' => "admin#index"


  delete '/admin/remove/:id' => "clients#remove"
  post '/admin/remote_update/:id' => "applications#remote_update", as:"remote_app"
  post '/admin/client_remote_update/:id' => "clients#remote_update", as:"remote_cl"

  
  scope "/admin" do
    resources :clients
    resources :companies
    resources :managers
    resources :developers
    resources :projects
    resources :applications
  end
  #match "*path", :to => "application#routing_error"

   root :to =>  redirect('/admin')

end
