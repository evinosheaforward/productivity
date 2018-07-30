Rails.application.routes.draw do
  get 'users/new'
  root 'accomplishments#index'
  resources :accomplishments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
