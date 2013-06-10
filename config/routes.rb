Jarvis::Application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions, only: [:new, :create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :users, only: [:new, :create]

  root to: 'sessions#new'

  scope 'api' do
    resources :expenses, only: [:create, :update]
  end

  if Rails.env.development? || Rails.env.test?
    mount Jasminerice::Engine => "/jasmine"
  end

  match '*path', :to => 'main#index'
end
