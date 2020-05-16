# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  get 'posts/new'
  get 'posts/show'
  get 'posts/edit'
  root 'top#index'
  get 'top/index'
  resources :posts

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'users/:id' => 'users#show'
end
