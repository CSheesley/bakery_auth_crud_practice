Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  get '/profile', to: 'bakers#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # namespace :pies do
  #   resources :ingredients, only: [:index]
  # end
  #
  # namespace :cakes do
  #   resources :ingredients, only: [:index]
  # end

  resources :bakers, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :recipes, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :ingredients, only: [:index]
    end
  end



  # baker log in
  # add/edit/delete a recipe
  # add/edit/delete ingredients to a recipe
  # log out

end
