IOSmanager::Application.routes.draw do
  

  get 'admin' => "admin#index"
 
 
  scope "/admin" do
    resources :clients
    resources :companies
    resources :managers
  end


  # root :to => 'welcome#index'
end
