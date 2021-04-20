# frozen_string_literal: true

Rails.application.routes.draw do
  post 'uploads/upload'
  get 'uploads/index'

  root to: 'uploads#index'
end
