Help::Application.routes.draw do

  resources :assets

	root :to => 'logins#new'

	get "login" => "logins#new", :as => "login"
	get "logout" => "logins#destroy", :as => "logout"
	
	match '/users/:seKey/become', :to => 'users#become', :as => 'become_user'
	match '/users/:id/increment_thanks', :to => 'users#increment_thanks', :as => 'increment_thanks'
	
	resources :tickets
	resources :users
	resources :departments
	resources :responses
	resources :statuses

	post 'login' => 'logins#create' 
	
end
