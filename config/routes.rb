Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index'
  post '/mypage/new', to: 'mypage#new', as: 'new_mypage'
  post '/mypage/destroy', to: 'mypage#destroy', as: 'destroy_mypage'
  post '/mypage/create', to: 'mypage#create', as: 'create_mypage'
  post '/mypage/increase_points', to: 'mypage#increase_points', as: 'increase_points_mypage' # テスト用
  post 'search/create', to: 'search#create', as: 'create_search'
  get 'search/update', to: 'search#update', as: 'update_search'
  resources :search, only: [:index, :new, :show]
  resource :mypage, controller: 'mypage', only: [:show, :new, :destroy, :create]
end
