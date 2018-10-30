Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "welcome:show"
  resources :users, only: [:new, :create] do
    resources :recipes, only: [:new, :create, :index, :update, :edit]
  end

  get '/recipes/ordered_by_name', to: 'recipes#name'
  resources :recipes, only: [:show, :index]
  

  get '/', to: "welcome#index", as: 'root'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  get '/auth/github/callback' => 'sessions#create'

end
