Akita::Application.routes.draw do
  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  # match '/signin' => 'sessions#new', :as => :signin
  match "/login" => redirect("/auth/google_oauth2")
  match '/signout' => 'sessions#destroy', :as => :signout

  root :to  => 'welcome#index'
end
