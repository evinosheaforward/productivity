Rails.application.routes.draw do
  root 'accomplishments#index'
  resources :accomplishments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
