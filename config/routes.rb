Akita::Application.routes.draw do
	devise_for :users, :controllers => { 
		:omniauth_callbacks => "users/omniauth_callbacks",
		:sessions => 'sessions'
	} do 
		match :logout, :to => 'sessions#destroy'
	end
	resources :users
	resources :links do 
		collection do 
			get 'page/:page', :action => :index
		end
		
		member do
			get 'go', action: :go
		end
	end
	
  root :to  => 'welcome#index'
end
