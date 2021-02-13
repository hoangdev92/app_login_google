require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  defaults format: :json do
    namespace :v1 do
      namespace :public do
        resource :authentication, path: 'auth', only: :create
      end

      namespace :private do
        resource :me, controller: :me, only: :show
      end

      namespace :admin, path: 'administer' do
        resources :legal_entities do
          patch 'restore', on: :member
        end
        resources :categories do
          patch 'restore', on: :member
        end
        resources :products do
          patch 'restore', on: :member
        end
        resources :funds do
          patch 'restore', on: :member
        end
      end
    end
  end
end
