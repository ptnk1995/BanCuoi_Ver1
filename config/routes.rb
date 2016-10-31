Rails.application.routes.draw do

  root "static_pages#index"
  get "contact", to: "static_pages#contact"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users, expect: :destroy
  resources :suggest_questions
  resources :exams
  resources :users, expect: [:destroy] do
	resources :following, only: [:index]
	resources :followers, only: [:index]
	end
  namespace :admin do
    root "home#index", as: "root"
    resources :categories
    resources :questions
    resources :answers
    resources :users
    resources :exams
    resources :suggest_questions
  end
  resources :relationships, only: [:create, :destroy]
end
