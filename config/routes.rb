Jarvis::Application.routes.draw do
  root to: 'main#index'

  scope 'api' do
    resources :expenses, only: [:create, :update]
  end

  if Rails.env.development? || Rails.env.test?
    mount Jasminerice::Engine => "/jasmine"
  end

  match '*path', :to => 'main#index'
end
