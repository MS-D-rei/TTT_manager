Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'users#show'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  namespace :user do
    root 'users#show' # creates user_root_path
  end

  resources :users, only: %i[index show]
  resources :topics, only: %i[show create edit update destroy]
  resources :teams, only: %i[index show create edit update destroy]
  resources :assigns, only: %i[create destroy]
  resources :tasks, only: %i[show create edit update destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
