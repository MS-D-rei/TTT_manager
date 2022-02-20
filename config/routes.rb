Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'users#show'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_sign_in_as_normal', to: 'users/sessions#guest_sign_in_as_normal'
  end

  resources :users, only: %i[index show] do
    collection do
      get 'search'
    end
  end
  resources :topics, only: %i[show create edit update destroy]
  resources :teams, only: %i[index show create edit update destroy]
  resources :assigns, only: %i[create destroy]
  resources :tasks, only: %i[show create edit update destroy] do
    collection do
      get 'search'
    end
  end
  resources :bookmarks, only: %i[index create destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
