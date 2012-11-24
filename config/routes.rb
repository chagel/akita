Akita::Application.routes.draw do
	devise_for :moderators
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

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
		
	end

	resources :favorites
	resources :urls
	resources :invites
	
	match :apply, controller: 'applies'
	
  root :to  => 'welcome#index'
end
