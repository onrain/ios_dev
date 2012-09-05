IOSmanager::Application.routes.draw do

  get 'admin' => "admin#index"
 
 
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
