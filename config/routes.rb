Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "welcome:show"
  resources :users do
    resources :recipes, only: [:new, :create, :index, :update, :edit]
  end

  resources :recipes
  resources :sessions
  

  get '/', to: "welcome#index"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
end
