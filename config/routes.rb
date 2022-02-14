Rails.application.routes.draw do
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

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
