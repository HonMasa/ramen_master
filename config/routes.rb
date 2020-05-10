# frozen_string_literal: true

Rails.application.routes.draw do
  root 'top#index'
  get 'top/index'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
