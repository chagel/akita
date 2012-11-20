Akita::Application.routes.draw do
	devise_for :users, :controllers => { 
		:omniauth_callbacks => "users/omniauth_callbacks",
		:sessions => 'sessions',
		:registrations => 'registrations',
	} 
	
	devise_scope :user do 
		get :login, :to => 'sessions#new'
		match :logout, :to => 'sessions#destroy'
		match :signup, :to => 'registrations#new'
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

	resources :favorites
	resources :urls
	
	match :apply, controller: 'applies'
	
  root :to  => 'welcome#index'
end
