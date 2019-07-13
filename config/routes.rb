Rails.application.routes.draw do
  devise_for :users
  root "images#new"

  get "images/new", to: "images#new"
  get "images/:id", to: "images#show"
  post "images/annotate", to: "images#update"

  get "annotations", to: "annotations#index"
end
