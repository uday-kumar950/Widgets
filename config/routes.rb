Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users do
  	collection do
  		get :update_password
  		post :reset_password
  	end
  end
  resources :widgets do
  	collection do 
  		get :search
  	end
  end
  # get 'widgets/index'
  # get 'widgets/new'
  # post 'widgets/create' => 'widgets#create'
  root 'widgets#index'

  #get 'widgets/search' => 'widgets#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
