Jarvis::Application.routes.draw do
  scope 'api' do
    resources :expenses, only: [:create, :update, :show]
  end

  if Rails.env.development? || Rails.env.test?
    Rails.application.routes.draw do
      mount Jasminerice::Engine => "/jasmine"
    end
  end

  root to: 'main#index'
end
