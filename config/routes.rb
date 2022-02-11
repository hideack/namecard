Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/authorize' => 'auth#gettoken'
  get '/main' => 'main#index'
end
